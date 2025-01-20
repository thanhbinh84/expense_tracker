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
      return ListView.builder(
        itemCount: trxList.length,
        itemBuilder: (context, index) {
          final trx = trxList[index];
          final item = TrxItem(trx.amount, trx.desc);

          return ListTile(
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
          );
        },
      );
    });
  }

  _floatingActionButton(BuildContext ctx) {
    return FloatingActionButton(
      onPressed: () => controller.goToAddTrxScreen(),
      child: const Icon(Icons.add),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class TrxItem implements ListItem {
  final double amount;
  final String desc;

  TrxItem(this.amount, this.desc);

  @override
  Widget buildTitle(BuildContext context) => Text(desc);

  @override
  Widget buildSubtitle(BuildContext context) => Text('€${amount.toString()}');
}
