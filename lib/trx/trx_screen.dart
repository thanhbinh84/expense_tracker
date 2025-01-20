import 'package:expense_tracker/core/widget/base_screen.dart';
import 'package:expense_tracker/trx/trx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TrxScreen extends GetView<TrxController> {
  const TrxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: 'Add expense',
        controller: controller,
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [_amountInputView(context), _descriptionInputView(context), _saveButton(context)],
          ),
        ));
  }

  Widget _amountInputView(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Amount',
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) => controller.updateTrx(amount: value),
    );
  }

  Widget _descriptionInputView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Description',
        ),
        onChanged: (value) => controller.updateTrx(desc: value),
      ),
    );
  }

  _saveButton(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(onPressed: () => controller.saveTrx(), child: Text('Save')),
    );
  }
}
