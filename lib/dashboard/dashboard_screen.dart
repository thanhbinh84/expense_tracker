import 'package:expense_tracker/core/widget/base_screen.dart';
import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: 'Transactions',
        controller: controller,
        floatingActionButton: _floatingActionButton(context),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ));
  }

  _floatingActionButton(BuildContext ctx) {
    return FloatingActionButton(
      onPressed: () => print('add new transaction'),
      child: const Icon(Icons.add),
    );
  }
}


