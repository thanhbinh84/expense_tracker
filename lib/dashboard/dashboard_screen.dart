import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/util/utils.dart';
import 'package:expense_tracker/core/widget/base_screen.dart';
import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:grouped_list/grouped_list.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: 'Transactions',
        controller: controller,
        floatingActionButton: _floatingActionButton(context),
        _trxListView(context));
  }

  Widget _trxListView(BuildContext context) {
    return Obx(() {
      final trxList = controller.trxList.value;
      if (trxList.isEmpty) return _noTrxHistoryView(context);
      return _groupedListView(context, trxList);
    });
  }

  _noTrxHistoryView(context) => Center(
      child: Text('No transaction history\nClick the + button to add expense',
          style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,));

  _floatingActionButton(BuildContext ctx) {
    return FloatingActionButton(
      onPressed: () => controller.goToAddTrxScreen(),
      child: const Icon(Icons.add),
    );
  }

  _groupedListView(context, List<Trx> trxList) {
    return GroupedListView<Trx, DateTime>(
      elements: trxList,
      groupBy: (trx) {
        final date = trx.dateTime;
        return DateTime(date.year, date.month, date.day);
      },
      order: GroupedListOrder.DESC,
      groupSeparatorBuilder: (DateTime value) => Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 8, top: 25),
        child: Text(
          utils.convertDateToString(value),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      itemBuilder: (context, trx) {
        return Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: SizedBox(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              leading: const Icon(Icons.account_circle),
              title: Text(trx.desc),
              trailing: Text('€${trx.amount.toString()}', style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        );
      },
    );
  }
}
