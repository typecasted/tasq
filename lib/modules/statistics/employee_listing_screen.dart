import 'package:flutter/material.dart';

class EmployeeListingScreenStats extends StatefulWidget {
  /// [EmployeeListingScreenStats] is used for the stats section when the user is logged in as [manager].
  /// it will show the list of the employee under the manager. 
  /// user can see the stats of the employee by clicking on the employee name. 
  const EmployeeListingScreenStats({super.key});

  @override
  State<EmployeeListingScreenStats> createState() => _EmployeeListingScreenStatsState();
}

class _EmployeeListingScreenStatsState extends State<EmployeeListingScreenStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}