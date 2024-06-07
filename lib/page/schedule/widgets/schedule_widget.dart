import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timeroute/page/schedule/controllers/schedule_controller.dart';
import 'package:timeroute/page/schedule/model/course.dart';
import 'package:timeroute/page/schedule/model/schedule.dart';
import 'package:timeroute/page/schedule/utils/schedule_util.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  final scheduleController = Get.find<ScheduleController>();

  final List<Widget> _item = [];

  final List<String> week = [
    '월',
    '화',
    '수',
    '목',
    '금',
    '토',
    '일',
  ];

  final Map<String, int> weekIndex = {
    '월': 0,
    '화': 0,
    '수': 0,
    '목': 0,
    '금': 0,
    '토': 0,
    '일': 0,
  };

  Map<String, bool> dayHover = {
    '월': false,
    '화': false,
    '수': false,
    '목': false,
    '금': false,
    '토': false,
    '일': false,
  };

  // 2개의 파스텔 색상 세트 (7개 씩 서로 달라야 함)
  final colorSet = [
    [
      Colors.pink[100]!,
      Colors.pink[200]!,
      Colors.pink[300]!,
      Colors.pink[400]!,
      Colors.pink[500]!,
      Colors.pink[600]!,
      Colors.pink[700]!,
    ],
    [
      Colors.blue[100]!,
      Colors.blue[200]!,
      Colors.blue[300]!,
      Colors.blue[400]!,
      Colors.blue[500]!,
      Colors.blue[600]!,
      Colors.blue[700]!,
    ],
  ];

  static const double kTableWidth = 700;
  static const double kTimeColumnWidth = 30;
  static const int kColumnLength = 30;
  static const double kFirstColumnHeight = 20;
  static const double kBoxSize = 100;

  @override
  void initState() {
    super.initState();

    scheduleController.schedules.listen((schedules) {
      setState(() {
        _item.clear();
        for (var schedule in schedules) {
          addSchedule(schedule);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
        width: kTableWidth,
        height: kColumnLength / 2 * kBoxSize + kFirstColumnHeight + 2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(children: [
          Row(
            children: [
              buildTimeColumn(),
              ...buildDayColumn(0),
              ...buildDayColumn(1),
              ...buildDayColumn(2),
              ...buildDayColumn(3),
              ...buildDayColumn(4),
              ...buildDayColumn(5),
              ...buildDayColumn(6),
            ],
          ),
          for (var item in _item) item,
        ]),
      ),
    );
  }

  Container buildTimeColumn() {
    return Container(
      width: kTimeColumnWidth,
      child: Column(
        children: [
          SizedBox(
            height: kFirstColumnHeight,
          ),
          ...List.generate(
            kColumnLength,
            (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: kBoxSize,
                child: Center(child: Text('${index ~/ 2 + 9}')),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> buildDayColumn(int index) {
    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Expanded(
        flex: 4,
        child: GestureDetector(
          onTap: () {
            final schedules = scheduleController.getSchedulesByDayOfWeekOrderByStart(week[index]);
            Get.toNamed('/', arguments: schedules);
          },
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                dayHover[week[index]] = true;
              });
            },
            onExit: (_) {
              setState(() {
                dayHover[week[index]] = false;
              });
            },
            child: Column(
              children: [
                SizedBox(
                  height: kFirstColumnHeight,
                  child: Text(week[index]),
                ),
                ...List.generate(
                  kColumnLength,
                  (idx) {
                    if (idx % 2 == 0) {
                      return const Divider(
                        color: Colors.grey,
                        height: 0,
                      );
                    }
                    return SizedBox(
                      height: kBoxSize,
                      child: Container(
                        color: dayHover[week[index]]! ? Colors.grey[200] : Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  void addSchedule(Schedule schedule) {
    final dayOfWeek = week.indexOf(schedule.day);
    final start = ScheduleUtil.convertStartToInt(schedule.start);
    final end = ScheduleUtil.convertEndToInt(schedule.end);

    try {
      Course? course = scheduleController.courses.firstWhere(
        (course) => course.no == schedule.courseNo,
      );
      _item.add(
        Positioned(
          top: kFirstColumnHeight + (kBoxSize / 2) * start,
          left: kTimeColumnWidth + (kTableWidth - kTimeColumnWidth) / week.length * dayOfWeek,
          height: (kBoxSize / 2) * (end - start + 1),
          width: (kTableWidth - kTimeColumnWidth) / week.length,
          child: Container(
            color: getColor(schedule.day),
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.courseName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(course.classroom ?? ''),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      log('Course not found');
    }
  }

  Color getColor(String dayOfWeek) {
    final dayOfWeekIndex = week.indexOf(dayOfWeek);
    weekIndex[dayOfWeek] = weekIndex[dayOfWeek]! + 1;
    return colorSet[dayOfWeekIndex % 2][(weekIndex[dayOfWeek]! - 1) % week.length];
  }
}
