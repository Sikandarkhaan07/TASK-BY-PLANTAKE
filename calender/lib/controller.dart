// ignore_for_file: invalid_use_of_protected_member, avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CalenderController extends GetxController {
  String boxName = 'calenderDatabase';
  late Iterable<dynamic> keys;
  RxInt num = 0.obs;
  int counter = 0;

  Map<DateTime, int> exerciseDays = <DateTime, int>{};

  void getDataByHIVE() {
    // Hive.deleteBoxFromDisk(boxName);
    keys = Hive.box(boxName).keys;
    keys.forEach((key) async {
      int value = Hive.box(boxName).get(key);
      exerciseDays[DateTime.parse(key)] = value;
    });
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    log("message $focusedDay .. $selectedDay");
    num++;
    if (!exerciseDays.containsKey(selectedDay)) {
      counter = 1;
      exerciseDays[selectedDay] = counter;
      await Hive.box(boxName).put(selectedDay.toString(), counter);
    } else {
      counter = exerciseDays[selectedDay]!;
      if (counter < 3 && counter > 0) {
        counter++;
        exerciseDays[selectedDay] = counter;
        await Hive.box(boxName).put(selectedDay.toString(), counter);
      }
    }
  }
}
