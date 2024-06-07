import 'package:timeroute/page/schedule/model/course.dart';

class Schedule {
  String day;
  String start;
  String end;
  int courseNo;

  Schedule({required this.courseNo, required this.day, required this.start, required this.end});

  @override
  String toString() {
    return 'Schedule{courseNo: $courseNo, day: $day, start: $start, end: $end}';
  }

  factory Schedule.fromJson(int courseNo, Map<String, dynamic> json) {
    return Schedule(
      courseNo: courseNo,
      day: json['day'],
      start: json['start'],
      end: json['end'],
    );
  }
}
