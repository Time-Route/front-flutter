class Schedule {
  String day;
  String start;
  String end;

  Schedule({required this.day, required this.start, required this.end});

  @override
  String toString() {
    return 'Period(day: $day, start: $start, end: $end)';
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'],
      start: json['start'],
      end: json['end'],
    );
  }
}
