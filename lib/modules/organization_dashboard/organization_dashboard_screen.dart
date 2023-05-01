import 'package:flutter/material.dart';
import 'package:tasq/modules/organization_dashboard/assignee/assignee_screen.dart';
import 'package:tasq/utils/local_storage.dart';
import 'manager/manager_screen.dart';

class OrganizationDashboardScreen extends StatefulWidget {
  const OrganizationDashboardScreen({super.key});

  @override
  State<OrganizationDashboardScreen> createState() =>
      _OrganizationDashboardScreenState();
}

class _OrganizationDashboardScreenState
    extends State<OrganizationDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: LocalStorage.getIsLoggedInAsManager(),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? snapshot.data!
                ? const ManagerScreen()
                : const AssigneeScreen()
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );

  }
}
