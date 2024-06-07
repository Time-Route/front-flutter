import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:timeroute/page/schedule/controllers/schedule_controller.dart';
import 'package:timeroute/page/schedule/model/course.dart';

class CourseListWidget extends StatefulWidget {
  final List<Course> courses;

  const CourseListWidget({Key? key, required this.courses}) : super(key: key);

  @override
  State<CourseListWidget> createState() => _CourseListWidgetState();
}

class _CourseListWidgetState extends State<CourseListWidget> {
  final scheduleController = Get.find<ScheduleController>();
  final List<int> _selectedRows = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _createColumns(),
        rows: _createRows(widget.courses),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('No')),
      DataColumn(label: Text('교과목코드')),
      DataColumn(label: Text('교과목명')),
      DataColumn(label: Text('강좌번호')),
      DataColumn(label: Text('이수구분')),
      DataColumn(label: Text('학점')),
      DataColumn(label: Text('주야')),
      DataColumn(label: Text('강의시간')),
      DataColumn(label: Text('제한인원')),
      DataColumn(label: Text('신청인원')),
      DataColumn(label: Text('외국인신청인원')),
      DataColumn(label: Text('국내교류학생')),
      DataColumn(label: Text('개설상위')),
      DataColumn(label: Text('개설학과')),
      DataColumn(label: Text('관리학과')),
      DataColumn(label: Text('교수직급')),
      DataColumn(label: Text('교수명')),
      DataColumn(label: Text('대표교수')),
      DataColumn(label: Text('대표교수명')),
      DataColumn(label: Text('강의실')),
      DataColumn(label: Text('과목영역')),
      DataColumn(label: Text('사이버강좌구분')),
      DataColumn(label: Text('강의언어')),
      DataColumn(label: Text('타과제한여부')),
      DataColumn(label: Text('주야교차가능여부')),
      DataColumn(label: Text('분반')),
      DataColumn(label: Text('타교생제한여부')),
      DataColumn(label: Text('구분')),
      DataColumn(label: Text('이론')),
      DataColumn(label: Text('실습')),
    ];
  }

  List<DataRow> _createRows(List<Course> courses) {
    return courses.map((course) {
      final index = courses.indexOf(course);
      final isSelected = _selectedRows.contains(index);
      return DataRow(
        selected: isSelected,
        onSelectChanged: (selected) {
          _handleRowSelected(selected ?? false, course, index);
        },
        cells: _buildCells(course),
      );
    }).toList();
  }

  List<DataCell> _buildCells(Course course) {
    return [
      DataCell(Text(course.no.toString())),
      DataCell(Text(course.courseCode.toString())),
      DataCell(Text(course.courseName.toString())),
      DataCell(Text(course.courseNumber.toString())),
      DataCell(Text(course.courseType.toString())),
      DataCell(Text(course.credit.toString())),
      DataCell(Text(course.dayNight.toString())),
      DataCell(Text(course.lectureTime.toString())),
      DataCell(Text(course.maxStudents.toString())),
      DataCell(Text(course.enrolledStudents.toString())),
      DataCell(Text(course.foreignEnrolledStudents.toString())),
      DataCell(Text(course.domesticExchangeStudents.toString())),
      DataCell(Text(course.topLevelDepartment.toString())),
      DataCell(Text(course.openingDepartment.toString())),
      DataCell(Text(course.managingDepartment.toString())),
      DataCell(Text(course.professorPosition.toString())),
      DataCell(Text(course.professorName.toString())),
      DataCell(Text(course.representativeProfessor.toString())),
      DataCell(Text(course.representativeProfessorName.toString())),
      DataCell(Text(course.classroom.toString())),
      DataCell(Text(course.courseArea.toString())),
      DataCell(Text(course.cyberLectureType.toString())),
      DataCell(Text(course.lectureLanguage.toString())),
      DataCell(Text(course.otherDepartmentRestriction.toString())),
      DataCell(Text(course.dayNightCrossAvailable.toString())),
      DataCell(Text(course.subclass.toString())),
      DataCell(Text(course.otherUniversityStudentRestriction.toString())),
      DataCell(Text(course.classification.toString())),
      DataCell(Text(course.theory.toString())),
      DataCell(Text(course.practice.toString())),
    ];
  }

  void _handleRowSelected(bool selected, Course course, int index) {
    setState(() {
      if (selected) {
        if (scheduleController.addCourse(course)) {
          _selectedRows.add(index);
        } else {
          Get.snackbar(
            '알림',
            '같은 시간대에 이미 추가된 강의가 있습니다.',
            duration: 1.seconds,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.lightBlue,
          );
        }
      } else {
        _selectedRows.remove(index);
        scheduleController.removeCourse(course);
      }
    });
  }
}
