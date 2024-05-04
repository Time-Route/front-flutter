import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeroute/page/schedule/model/course.dart';
import 'package:timeroute/page/schedule/model/schedule.dart';
import 'package:timeroute/page/schedule/widgets/course_list_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'controllers/course_controller.dart';
import 'controllers/schedule_controller.dart';
import 'widgets/schedule_widget.dart';

List<String> week = [
  '월',
  '화',
  '수',
  '목',
  '금'
];

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final courseController = Get.put(Courseontroller());
  final scheduleController = Get.put(ScheduleController());
  // 왼쪽 사이드
  String _selectedTitle = week[0]; // Default title
  int _startNumber = 0;
  int _endNumber = 0;

  List<Course> courses = [];

  // Function to handle title selection
  void _onTitleSelected(String? title) {
    setState(() {
      _selectedTitle = title!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSelection(),
            ScheduleWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildSelection() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '시작 교시',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _startNumber = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              '종료 교시',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _endNumber = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              '제목:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedTitle,
              onChanged: _onTitleSelected,
              items: week.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextButton(
              onPressed: () {
                // addSchedule(
                //   dayOfWeek: week.indexOf(_selectedTitle),
                //   startPeriod: _startNumber - 1,
                //   endPeriod: _endNumber - 1,
                // );
              },
              child: Text('추가하기'),
            ),
            TextButton(
                onPressed: () {
                  courseController.fetchSchedule();
                },
                child: Text('불러오기')),
            Obx(() {
              if (courseController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                return CourseListWidget(courses: courseController.courses);
              }
            }),
          ],
        ),
      ),
    );
  }
}
