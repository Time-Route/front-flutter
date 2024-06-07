import 'package:timeroute/page/schedule/model/schedule.dart';

class Course {
  final int no;
  final int? courseCode;
  final String courseName;
  final int? courseNumber;
  final String? courseType;
  final double? credit;
  final String? dayNight;
  final String? lectureTime;
  final int? maxStudents;
  final int? enrolledStudents;
  final int? foreignEnrolledStudents;
  final int? domesticExchangeStudents;
  final String? topLevelDepartment;
  final String? openingDepartment;
  final String? managingDepartment;
  final String? professorPosition;
  final String? professorName;
  final int? representativeProfessor;
  final String? representativeProfessorName;
  final String? classroom;
  final String? courseArea;
  final String? cyberLectureType;
  final String? lectureLanguage;
  final String? otherDepartmentRestriction;
  final String? dayNightCrossAvailable;
  final String? subclass;
  final String? otherUniversityStudentRestriction;
  final String? classification;
  final int? theory;
  final int? practice;
  final List<Schedule>? schedules;

  Course({
    required this.no,
    required this.courseCode,
    required this.courseName,
    required this.courseNumber,
    required this.courseType,
    required this.credit,
    required this.dayNight,
    required this.lectureTime,
    required this.maxStudents,
    required this.enrolledStudents,
    required this.foreignEnrolledStudents,
    required this.domesticExchangeStudents,
    required this.topLevelDepartment,
    required this.openingDepartment,
    required this.managingDepartment,
    required this.professorPosition,
    required this.professorName,
    required this.representativeProfessor,
    required this.representativeProfessorName,
    required this.classroom,
    required this.courseArea,
    required this.cyberLectureType,
    required this.lectureLanguage,
    required this.otherDepartmentRestriction,
    required this.dayNightCrossAvailable,
    required this.subclass,
    required this.otherUniversityStudentRestriction,
    required this.classification,
    required this.theory,
    required this.practice,
    required this.schedules,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      no: json['No'],
      courseCode: json['교과목코드'],
      courseName: json['교과목명'],
      courseNumber: json['강좌번호'],
      courseType: json['이수구분'],
      credit: json['학점'].toDouble(),
      dayNight: json['주야'],
      lectureTime: json['강의시간'],
      maxStudents: json['제한인원'],
      enrolledStudents: json['신청인원'],
      foreignEnrolledStudents: json['외국인신청인원'],
      domesticExchangeStudents: json['국내교류학생'],
      topLevelDepartment: json['개설상위'],
      openingDepartment: json['개설학과'],
      managingDepartment: json['관리학과'],
      professorPosition: json['교수직급'],
      professorName: json['교수명'],
      representativeProfessor: json['대표교수'],
      representativeProfessorName: json['대표교수명'],
      classroom: json['강의실'],
      courseArea: json['과목영역'],
      cyberLectureType: json['사이버강좌구분'],
      lectureLanguage: json['강의언어'],
      otherDepartmentRestriction: json['타과제한여부'],
      dayNightCrossAvailable: json['주야교차가능여부'],
      subclass: json['분반'],
      otherUniversityStudentRestriction: json['타교생제한여부'],
      classification: json['구분'],
      theory: json['이론'],
      practice: json['실습'],
      schedules: json['schedules'].map<Schedule>((e) => Schedule.fromJson(json['No'], e)).toList(),
    );
  }
}
