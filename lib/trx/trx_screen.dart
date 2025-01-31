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
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                DescriptionInputView(),
                AmountInputView(),
                DateInputView(),
                CategoryMenuView(),
                SaveButton()
              ],
            ),
          ),
        ));
  }
}

class CategoryMenuView extends StatelessWidget {
  const CategoryMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TrxController.to;
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
          );
        }).toList(),
      ),
    );
  }
}


class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ElevatedButton(
          key: Key(Txt.save),
          onPressed: () => TrxController.to.saveTrx(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(Txt.save),
          )),
    );
  }
}


class DateInputView extends StatelessWidget {
  const DateInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        key: Key(Txt.date),
        controller: TrxController.to.dateInputController,
        showCursor: false,
        readOnly: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: Txt.date,
        ),
        onTap: () => _showDatePicker(context),
      ),
    );
  }

  _showDatePicker(context) async {
    final today = DateTime.now();
    final firstDate = today.subtract(Duration(days: 365));
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: TrxController.to.trx.dateTime,
        firstDate: firstDate,
        lastDate: today);

    if (selectedDate != null && context.mounted) TrxController.to.updateTrx(dateTime: selectedDate);
  }
}


class AmountInputView extends StatelessWidget {
  const AmountInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        key: Key(Txt.amount),
        validator: (value) {
          final num = double.tryParse(value ?? '') ?? 0;
          if (num <= 0) {
            return Txt.pleaseEnterAmount;
          }
          return null;
        },
        maxLength: 10,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: Txt.amount,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => TrxController.to.updateTrx(amount: value),
      ),
    );
  }
}


class DescriptionInputView extends StatelessWidget {
  const DescriptionInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        key: Key(Txt.description),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return Txt.pleaseEnterDescription;
          }
          return null;
        },
        maxLength: 50,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: Txt.description,
        ),
        onChanged: (value) => TrxController.to.updateTrx(desc: value),
      ),
    );
  }
}

