import 'dart:developer';

import 'package:get/get.dart';
import 'package:timeroute/page/schedule/model/course.dart';
import 'package:timeroute/page/schedule/model/schedule.dart';
import 'package:timeroute/page/schedule/utils/schedule_util.dart';

class ScheduleController extends GetxController {
  final courses = <Course>[].obs;
  final schedules = <Schedule>[].obs;

  bool addCourse(Course newCourse) {
    if (ScheduleUtil.checkOverlap(newCourse.schedules, schedules)) {
      log('시간표가 겹칩니다.');
      return false;
    }

    courses.add(newCourse);
    for (var schedule in newCourse.schedules!) {
      schedules.add(schedule);
    }
    return true;
  }

  void removeCourse(Course course) {
    courses.remove(course);
    for (var schedule in course.schedules!) {
      schedules.remove(schedule);
    }
  }
}
