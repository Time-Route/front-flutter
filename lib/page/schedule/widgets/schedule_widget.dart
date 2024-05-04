import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeroute/page/schedule/controllers/schedule_controller.dart';
import 'package:timeroute/page/schedule/model/schedule.dart';
import 'package:timeroute/page/schedule/utils/schedule_util.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  final scheduleController = Get.find<ScheduleController>();

  List<Widget> _item = [];

  List<String> week = [
    '월',
    '화',
    '수',
    '목',
    '금'
  ];

  static const double kTableWidth = 700;
  static const double kTimeColumnWidth = 30;
  static const int kColumnLength = 22;
  static const double kFirstColumnHeight = 20;
  static const double kBoxSize = 70;

  @override
  void initState() {
    super.initState();

    scheduleController.schedules.listen((schedules) {
      _item.clear();
      for (var schedule in schedules) {
        addSchedule(schedule);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
        width: kTableWidth,
        height: kColumnLength / 2 * kBoxSize + kColumnLength,
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: Text(
                '${week[index]}',
              ),
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
                  child: Container(),
                );
              },
            ),
          ],
        ),
      ),
    ];
  }

  void addSchedule(Schedule schedule) {
    final dayOfWeek = week.indexOf(schedule.day);
    final start = ScheduleUtil.convertStartToInt(schedule.start);
    final end = ScheduleUtil.convertEndToInt(schedule.end);
    setState(() {
      _item.add(
        Positioned(
          top: kFirstColumnHeight + (kBoxSize / 2) * start,
          left: kTimeColumnWidth + (kTableWidth - kTimeColumnWidth) / 5 * dayOfWeek,
          height: (kBoxSize / 2) * (end - start + 1),
          width: (kTableWidth - kTimeColumnWidth) / 5,
          child: Container(
            color: Colors.green,
          ),
        ),
      );
    });
  }
}
