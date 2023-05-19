// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer' as db;

import 'package:calender/circle.dart';
import 'package:flutter/material.dart';
import 'package:calendar_builder/calendar_builder.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Task3 extends StatefulWidget {
  @override
  State<Task3> createState() => _Task3State();
}

class _Task3State extends State<Task3> {
  //hive coding..............
  var boxName = 'calenderData';

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
    keys.forEach((key) {
      exerciseDates[key] = openBox.get(key);
    });
  }

  //hive coding ends here.......................

  int i = 0;
  Map<String, dynamic> exerciseDates = {};

  @override
  void initState() {
    //initising hive
    initHive();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 190, 111),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              //deleting entire box from the disk using HIVE
              await Hive.deleteBoxFromDisk(boxName);
            },
            icon: const Icon(Icons.remove),
          ),
        ],
        title: const Text('Calender'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 8,
                  blurStyle: BlurStyle.inner,
                  spreadRadius: 5),
            ],
          ),
          child: CbMonthBuilder(
            onDateClicked: (onDateSelected) async {
              if (!onDateSelected.isSelected) {
                i = 0;
              }
              if (onDateSelected.isCurrentDate) {}
              //data storing using HIVE
              if (!onDateSelected.isDisabled) {
                db.log("Clicked...  ${onDateSelected.isDisabled}");
                if (i == 0) {
                  i = 1;
                  await Hive.box(boxName).put(
                      onDateSelected.selectedDate.toString().substring(0, 10),
                      i);

                  getDataByHIVE();
                  setState(() {});
                }
              }
            },
            cbConfig: CbConfig(
              // currentDay: DateTime.now(),
              startDate: DateTime(2020),
              endDate: DateTime(2036),
              selectedDate: DateTime.now(),
              selectedYear: DateTime(2023),
              weekStartsFrom: WeekStartsFrom.monday,
            ),
            yearDropDownCustomizer: YearDropDownCustomizer(
              yearHeaderBuilder:
                  (isYearPickerExpanded, selectedDate, selectedYear, year) {
                return Container(
                  height: 40,
                  color: const Color.fromARGB(255, 172, 169, 138),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        year,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(!isYearPickerExpanded
                          ? Icons.arrow_drop_down_outlined
                          : Icons.arrow_drop_up_outlined)
                    ],
                  ),
                );
              },
            ),
            monthCustomizer: MonthCustomizer(
              scrollToSelectedMonth: true,
              montMinhHeight: 300,
              monthMinWidth: double.infinity,
              monthButtonCustomizer: MonthButtonCustomizer(),
              padding: const EdgeInsets.all(5),
              monthWeekBuilder: (index, weeks, weekHeight, weekWidth) {
                return SizedBox(
                  height: weekHeight,
                  width: weekWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Align(
                        child: Text(
                          weeks,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                );
              },
              monthHeaderBuilder:
                  (month, headerHeight, headerWidth, paddingLeft) {
                return Container(
                  height: headerHeight,
                  width: headerWidth,
                  decoration: const BoxDecoration(color: Colors.black12),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      month,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
              monthButtonBuilder: (dateTime,
                  childHeight,
                  childWidth,
                  isSelected,
                  isDisabled,
                  hasEvent,
                  isHighlighted,
                  isCurrentDay) {
                var daysText = Align(
                  child: Text(
                    '${dateTime.day}',
                    style: TextStyle(
                      color:
                          exerciseDates[dateTime.toString().substring(0, 10)] ==
                                  1
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                );
                if (isSelected && !isDisabled) {
                  return CustomPaint(
                    foregroundPainter: arc(
                        i: exerciseDates[
                                dateTime.toString().substring(0, 10)] ??
                            i),
                    child: Container(
                      width: childWidth,
                      height: childHeight,
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.all(5),
                      child: daysText,
                    ),
                  );
                }
                if (dateTime.toString().substring(0, 10) ==
                    exerciseDates[dateTime.toString().substring(0, 10)]) {}
                return CustomPaint(
                  foregroundPainter: !isDisabled
                      ? arc(
                          i: exerciseDates[
                                  dateTime.toString().substring(0, 10)] ??
                              0)
                      : arc(i: 0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: isDisabled ? Colors.grey[200] : Colors.yellow,
                        shape: BoxShape.circle,
                        border: hasEvent || isHighlighted
                            ? Border.all(
                                color: isHighlighted ? Colors.red : Colors.blue,
                                width: 4)
                            : null),
                    margin: const EdgeInsets.all(5),
                    child: daysText,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
