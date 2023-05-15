// ignore_for_file: library_private_types_in_public_api, prefer_for_elements_to_map_fromiterable

import 'dart:developer' as dp;

import 'package:calender/header.dart';
import 'package:calender/utils.dart';
import 'package:flutter/material.dart';

import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TableComplexExample extends StatefulWidget {
  const TableComplexExample({super.key});

  @override
  _TableComplexExampleState createState() => _TableComplexExampleState();
}

class _TableComplexExampleState extends State<TableComplexExample> {
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  //hive coding..............
  var boxName = 'calenderDatabase';
  late Iterable<dynamic> keys;

  void initHive() async {
    final path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    Hive.openBox(boxName).then((value) {
      setState(() {
        getDataByHIVE();
      });
    });
  }

  void getDataByHIVE() {
    final openBox = Hive.box(boxName);
    keys = openBox.keys;
    keys.forEach((key) async {
      var date = Hive.box(boxName).get(key);
      _selectedDays.add(date);
    });
  }

  @override
  void initState() {
    super.initState();
    initHive();
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if ((selectedDay.day == focusedDay.day) &&
        (selectedDay.isBefore(DateTime.now()))) {
      //store data into HIVE
      await Hive.box(boxName).put(selectedDay.toString(), selectedDay);
      //get all keys
      keys = Hive.box(boxName).keys;

      if (_selectedDays.contains(selectedDay)) {
        await Hive.box(boxName).delete(selectedDay.toString());
        _selectedDays.remove(selectedDay);
      } else {
        await Hive.box(boxName).put(selectedDay.toString(), selectedDay);
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TableCalendar - Complex'),
      ),
      body: Container(
        height: 400,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ValueListenableBuilder<DateTime>(
              valueListenable: _focusedDay,
              builder: (context, value, _) {
                return CalendarHeader(
                  focusedDay: value,
                  clearButtonVisible: false,
                  onTodayButtonTap: () {
                    setState(() => _focusedDay.value = DateTime.now());
                  },
                  onClearButtonTap: () {
                    setState(() {
                      _rangeStart = null;
                      _rangeEnd = null;
                      _selectedDays.clear();
                    });
                  },
                  onLeftArrowTap: () {
                    dp.log("Left....");
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                  onRightArrowTap: () {
                    dp.log("Right....");
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                );
              },
            ),
            TableCalendar<Event>(
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: const Border(
                    top: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                    bottom: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay.value,
              headerVisible: false,
              selectedDayPredicate: (day) => _selectedDays.contains(day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              onDaySelected: _onDaySelected,
              onCalendarCreated: (controller) => _pageController = controller,
              onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() => _calendarFormat = format);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
