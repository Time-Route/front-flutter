import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:timeroute/global/global.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: '아이디'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final id = idController.text;
                final password = passwordController.text;

                dio
                    .get('http://localhost:3000/api/auth/login/?userId=${id}&password=${password}',
                        options: Options(
                          headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json',
                          },
                        ))
                    .then((response) {
                  print(response.data);
                }).catchError((error) {
                  print('에러 발생');
                  print(error);
                });
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('회원가입'),
            ),
            TextButton(
              onPressed: () {
                dio.get('http://localhost:3000/api/auth/protected').then((response) {
                  print(response.data);
                }).catchError((error) {
                  print('에러 발생');
                  print(error);
                });
              },
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
