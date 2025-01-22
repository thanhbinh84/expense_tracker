import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/util/const/txt.dart';
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
            children: [
              _descriptionInputView(context),
              _amountInputView(context),
              _dateInputView(context),
              _categoryMenuView(context),
              _saveButton(context)
            ],
          ),
        ));
  }

  Widget _descriptionInputView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        key: Key(Txt.description),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText:Txt.description,
        ),
        onChanged: (value) => controller.updateTrx(desc: value),
      ),
    );
  }

  Widget _amountInputView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        key: Key(Txt.amount),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText:Txt.amount,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => controller.updateTrx(amount: value),
      ),
    );
  }

  Widget _dateInputView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        key: Key(Txt.date),
        controller: controller.dateInputController,
        showCursor: false,
        readOnly: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText:Txt.date,
        ),
        onTap: () => _showDatePicker(context),
      ),
    );
  }

  _saveButton(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ElevatedButton(
          key: Key(Txt.save),
          onPressed: () => controller.saveTrx(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(Txt.save),
          )),
    );
  }

  _showDatePicker(context) async {
    final today = DateTime.now();
    final firstDate = today.subtract(Duration(days: 365));
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: controller.trx.dateTime,
        firstDate: firstDate,
        lastDate: today);

    if (selectedDate != null && context.mounted) controller.updateTrx(dateTime: selectedDate);
  }

  _categoryMenuView(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: DropdownMenu<Category>(
        key: Key(Txt.category),
        width: double.infinity,
        initialSelection: controller.trx.category,
        controller: controller.categoryInputController,
        label: const Text(Txt.category),
        onSelected: (Category? category) => controller.updateTrx(category: category),
        dropdownMenuEntries: Category.list.map<DropdownMenuEntry<Category>>((Category category) {
          return DropdownMenuEntry<Category>(
            value: category,
            label: category.name,
            // style: MenuItemButton.styleFrom(
            //   foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            // ),
          );
        }).toList(),
      ),
    );
  }
}
