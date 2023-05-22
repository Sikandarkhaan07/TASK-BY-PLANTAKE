// ignore_for_file: deprecated_member_use

import 'dart:collection';

import 'package:calender/circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:path_provider/path_provider.dart';
import './controller.dart';
import 'circle_outlayer.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 2, 1);
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

class TableComplexExample extends StatefulWidget {
  const TableComplexExample({super.key});

  @override
  State<TableComplexExample> createState() => _TableComplexExampleState();
}

class _TableComplexExampleState extends State<TableComplexExample> {
  //init controller
  final controller = Get.put(CalenderController());

  late PageController _pageController;
  final ValueNotifier<int> month = ValueNotifier(DateTime.now().month);

  void initHive() async {
    final path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    Hive.openBox(controller.boxName).then((value) {
      setState(() {
        controller.getDataByHIVE();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initHive();
  }

  TextStyle dayStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'ROB',
      fontSize: 15);

  TextStyle weekStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'ROB',
      fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 15,
                blurRadius: 30,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(32)),
        child: Stack(
          children: [
            Obx(
              () => Column(
                children: [
                  Text(controller.num.value.toString()),
                  MediaQuery(
                    data:
                        MediaQueryData.fromView(WidgetsBinding.instance.window)
                            .copyWith(textScaleFactor: 1),
                    child: TableCalendar(
                      calendarBuilders: CalendarBuilders(
                        selectedBuilder: (context, day, focusedDay) {
                          return CustomPaint(
                            painter: CircleOutlayer(
                                i: controller.exerciseDays[day] ?? 0),
                            foregroundPainter:
                                arc(i: controller.exerciseDays[day] ?? 0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 4,
                                ),
                              ),
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "${day.day}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      rowHeight: 55,
                      daysOfWeekHeight: 40,
                      availableGestures: AvailableGestures.none,
                      focusedDay: kToday,
                      selectedDayPredicate: (day) =>
                          controller.exerciseDays.containsKey(day),
                      onDaySelected: controller.onDaySelected,
                      onPageChanged: (focusedDay) {
                        month.value = focusedDay.month;
                      },
                      rangeSelectionMode: RangeSelectionMode.disabled,
                      onCalendarCreated: (controller) =>
                          _pageController = controller,
                      calendarStyle: CalendarStyle(
                        selectedDecoration: const BoxDecoration(
                            color: Colors.indigoAccent, shape: BoxShape.circle),
                        selectedTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ROB',
                            fontSize: 15),
                        weekendTextStyle: dayStyle,
                        disabledTextStyle: dayStyle,
                        defaultTextStyle: dayStyle,
                        outsideDaysVisible: false,
                        isTodayHighlighted: false,
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: weekStyle, weekendStyle: weekStyle),
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        headerMargin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'ROB',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 30, width: 30, color: Colors.indigoAccent),
                        const Expanded(
                          child: Text("Excercised"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ValueListenableBuilder(
                valueListenable: month,
                builder: (context, int date, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: date == kFirstDay.month ? false : true,
                        child: GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.grey,
                            child: const Icon(Icons.chevron_left),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: date == kToday.month ? false : true,
                        child: GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.grey,
                            child: const Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
}..addAll({
    kToday: [
      // const Event('Today\'s Event 1'),
      // const Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
