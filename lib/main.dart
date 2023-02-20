import 'package:flutter/material.dart';
import './utils/app_colors.dart';
import './modules/sign_in/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasq',
      theme: ThemeData(
        primarySwatch: AppColors.materialColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SignInScreen(),
    );
  }
}
