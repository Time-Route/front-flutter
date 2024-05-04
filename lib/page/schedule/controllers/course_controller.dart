import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:timeroute/page/schedule/model/course.dart';

class Courseontroller extends GetxController {
  late Dio dio;

  final isLoading = false.obs;
  final courses = <Course>[].obs;

  @override
  void onInit() {
    super.onInit();

    dio = Dio();
  }

  void fetchSchedule() async {
    try {
      isLoading.value = true;
      final response = await dio.get("${dotenv.env['BASE_URL']}/api/timetable/?course=인공지능");
      List<dynamic> jsonList = response.data;
      courses.value = jsonList.map((e) => Course.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
