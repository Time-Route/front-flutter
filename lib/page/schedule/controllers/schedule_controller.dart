import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:timeroute/page/map/markers_data.dart';
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

  List<Map<String, dynamic>> getSchedulesByDayOfWeekOrderByStart(String dayOfWeek) {
    return schedules
        .where((schedule) => schedule.day == dayOfWeek)
        .map((schedule) => {
              'courseNo': schedule.courseNo,
              'building': markerList.firstWhere((element) => courses.firstWhere((course) => course.no == schedule.courseNo).classroom!.contains(element['id']))['id'],
              'start': schedule.start,
              'end': schedule.end,
            })
        .toList()
      ..sort((a, b) => int.parse(a['start'] as String).compareTo(int.parse(b['start'] as String)));
  }
}
