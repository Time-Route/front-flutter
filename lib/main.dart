import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:timeroute/global/global.dart';
import 'package:timeroute/page/auth/sign_in_screen.dart';
import 'package:timeroute/page/auth/sign_up_screen.dart';
import 'package:url_strategy/url_strategy.dart';

import 'page/schedule/schedule_screen.dart';
import 'page/map/map_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  setPathUrlStrategy();

  adapter.withCredentials = true;
  dio.httpClientAdapter = adapter;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          fontFamily: 'Pretendard',
          colorScheme: ColorScheme.light().copyWith(
            background: Colors.white,
          )),
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
        GetPage(
          name: '/signup',
          page: () => SignUpScreen(),
        ),
        GetPage(
          name: '/signin',
          page: () => SignInScreen(),
        ),
      ],
    );
  }
}
