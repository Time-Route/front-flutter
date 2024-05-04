import 'package:timeroute/page/schedule/model/schedule.dart';

class ScheduleUtil {
  static bool checkOverlap(List<Schedule>? scheduleList1, List<Schedule> scheduleList2) {
    if (scheduleList1 == null || scheduleList1.isEmpty) return false;

    for (var schedule1 in scheduleList1) {
      for (var schedule2 in scheduleList2) {
        if (schedule1.day == schedule2.day) {
          if (convertStartToInt(schedule1.start) < convertEndToInt(schedule2.end) && convertEndToInt(schedule1.end) > convertStartToInt(schedule2.start)) {
            return true;
          }
        }
      }
    }

    return false;
  }

  static int convertStartToInt(String input) {
    var number = int.parse(input.replaceAll(RegExp(r'[A-Z]'), ''));
    var modifier = input.replaceAll(RegExp(r'[0-9]'), '');
    return number * 2 + (modifier == 'B' ? 1 : 0);
  }

  static int convertEndToInt(String input) {
    var number = int.parse(input.replaceAll(RegExp(r'[A-Z]'), ''));
    var modifier = input.replaceAll(RegExp(r'[0-9]'), '');

    return number * 2 + (modifier == 'A' ? 0 : 1);
  }
}
