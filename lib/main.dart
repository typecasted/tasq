import 'package:flutter/material.dart';
import 'package:tasq/utils/local_storage.dart';
import './utils/app_colors.dart';
import './modules/sign_in/sign_in_screen.dart';
import 'modules/user_dashboard/user_dashboard.dart';
import 'utils/network_services/repository.dart';

main() async {
  await Repository.dryRunApi();
  await LocalStorage.initLocalStorage();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasq',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.materialColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder<bool>(
        future: LocalStorage.isUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return const Dashboard();
            } else {
              return const SignInScreen();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
