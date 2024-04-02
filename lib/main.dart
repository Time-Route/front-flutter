import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'page/schedule/schdule_screen.dart';
import 'page/map/map_screen.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => MapScreen(),
        ),
        GetPage(
          name: '/schedule',
          page: () => ScheduleScreen(),
        ),
      ],
    );
  }
}