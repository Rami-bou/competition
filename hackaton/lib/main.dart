import 'package:flutter/material.dart';
import 'package:hackaton/admin_pages/admin_page.dart';
import 'package:hackaton/hospital_dashbored/hospital_home.dart';
import 'package:hackaton/singuppage.dart';
import 'package:hackaton/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: hospital_home(),

    );
  }
}
