import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timeroute/page/schedule/model/course.dart';
import 'package:timeroute/page/schedule/widgets/course_list_widget.dart';

import 'controllers/course_controller.dart';
import 'controllers/schedule_controller.dart';
import 'widgets/schedule_widget.dart';

List<String> week = [
  '월',
  '화',
  '수',
  '목',
  '금',
  '토',
  '일',
];

final selectDayList = [
  '모두',
  '월',
  '화',
  '수',
  '목',
  '금',
  '토',
  '일'
];

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final courseController = Get.put(Courseontroller());
  final scheduleController = Get.put(ScheduleController());

  // 요일
  String _selectedDay = selectDayList[0];

  // 학점
  int _credits = 0;

  final courseNameController = TextEditingController();
  final startInputController = TextEditingController();
  final endInputController = TextEditingController();

  List<Course> courses = [];

  // Function to handle title selection
  void _onDaySelected(String? title) {
    setState(() {
      _selectedDay = title!;
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
            // 교과목명 검색
            TextField(
              controller: courseNameController,
              decoration: InputDecoration(
                hintText: '교과목명을 입력하세요',
              ),
            ),
            SizedBox(height: 16),
            // 요일
            Text('요일'),
            // 요일 선택
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: selectDayList
                  .map((title) => ChoiceChip(
                        label: Text(title),
                        selected: _selectedDay == title,
                        onSelected: (selected) {
                          _onDaySelected(selected ? title : null);
                        },
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),
            // 학점
            Text('학점'),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(5, (index) {
                return ChoiceChip(
                  label: Text(index.toString()),
                  selected: _credits == index,
                  onSelected: (selected) {
                    setState(() {
                      _credits = selected ? index : 0;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 16),
            Text('시작 교시'),
            TextField(
              controller: startInputController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height: 16),
            Text('종료 교시'),
            TextField(
              controller: endInputController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height: 16),

            // 불러오기 버튼 (색상 보라색)
            ElevatedButton(
              onPressed: () {
                if (courseNameController.text.isEmpty) {
                  Get.snackbar(
                    '알림',
                    '교과목명을 입력하세요',
                    duration: 1.seconds,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.lightBlue,
                  );
                  return;
                }

                courseController.fetchSchedule(
                  courseName: courseNameController.text,
                  day: _selectedDay == '모두' ? '' : _selectedDay,
                  start: startInputController.text.isEmpty ? 0 : int.parse(startInputController.text),
                  end: endInputController.text.isEmpty ? 0 : int.parse(endInputController.text),
                  credits: _credits,
                );
              },
              style: ButtonStyle(),
              child: Text('불러오기'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  if (courseController.isLoading.value) {
                    return CircularProgressIndicator();
                  } else {
                    return CourseListWidget(courses: courseController.courses);
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
