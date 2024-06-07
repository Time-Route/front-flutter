import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:timeroute/global/global.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            SizedBox(height: 20.0),
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
                final name = nameController.text;
                final id = idController.text;
                final password = passwordController.text;

                dio.get('http://localhost:3000/api/auth/register/?name=${name}&userId=${id}&password=${password}').then((response) {
                  print(response.data);
                });
              },
              child: Text('가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}
