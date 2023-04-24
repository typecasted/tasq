import 'package:flutter/material.dart';
import 'package:tasq/modules/otp/otp_screen.dart';
import 'package:tasq/utils/local_storage.dart';
import './utils/app_colors.dart';
import './modules/sign_in/sign_in_screen.dart';
import 'utils/network_services/repository.dart';

main() async {
  await Repository.dryRunApi();
  await LocalStorage.initLocalStorage();

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
      home: const OTPScreen(),
    );
  }
}
