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

  void fetchSchedule({
    required String courseName,
    required String day,
    required int start,
    required int end,
    required int credits,
  }) async {
    try {
      isLoading.value = true;
      String requestUrl = "${dotenv.env['BASE_URL']}/api/timetable/?";
      if (courseName.isNotEmpty) requestUrl += "course=$courseName&";
      if (day.isNotEmpty) requestUrl += "weekday=$day&";
      if (start != 0) requestUrl += "start=$start&";
      if (end != 0) requestUrl += "end=$end&";
      if (credits != 0) requestUrl += "credits=$credits&";
      log(requestUrl);

      final response = await dio.get(requestUrl);
      List<dynamic> jsonList = response.data;
      courses.value = jsonList.map((e) => Course.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
