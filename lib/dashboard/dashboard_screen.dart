import 'package:expense_tracker/core/widget/base_screen.dart';
import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
          child: _trxListView(context),
        ));
  }

  Widget _trxListView(BuildContext context) {
    return Obx(() {
      final trxList = controller.trxList.value;
      if (trxList.isEmpty) return Container();
      return Column(children: trxList.map((e) => Text(e.desc)).toList());
    });
  }

  _floatingActionButton(BuildContext ctx) {
    return FloatingActionButton(
      onPressed: () => print('add new transaction'),
      child: const Icon(Icons.add),
    );
  }
}
