// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management/VIew/Login.dart';
import 'package:library_management/VIew/RegisterUser.dart';
import 'package:library_management/VIew/website.dart';
void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Web Auth',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => Website()),  // Add the route for HomePage
      ],
    );
  }
}
