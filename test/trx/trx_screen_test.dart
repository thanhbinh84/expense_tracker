import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:expense_tracker/core/util/const/txt.dart';
import 'package:expense_tracker/trx/trx_controller.dart';
import 'package:expense_tracker/trx/trx_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../helper.dart';

void main() {
  late TrxController trxController;
  setUp(() {
    Get.put<TrxRepository>(ManualMockTrxRepository());
    trxController = Get.put(TrxController());
  });

  testWidgets('The screen displays description, amount, date, category and save button', (tester) async {
    await tester.pumpGetApp(TrxScreen());
    expect(find.byKey(Key(Txt.description)), findsOneWidget);
    expect(find.byKey(Key(Txt.amount)), findsOneWidget);
    expect(find.byKey(Key(Txt.date)), findsOneWidget);
    expect(find.byKey(Key(Txt.category)), findsOneWidget);
    expect(find.byKey(Key(Txt.save)), findsOneWidget);
  });


  testWidgets('Description field is able to input', (tester) async {
    await tester.pumpGetApp(TrxScreen());
    await tester.enterText(find.byKey(Key(Txt.description)), mockTrx1.desc);
    expect(trxController.trx.desc == mockTrx1.desc, true);
  });

  testWidgets('Amount field is able to input', (tester) async {
    await tester.pumpGetApp(TrxScreen());
    await tester.enterText(find.byKey(Key(Txt.amount)), mockTrx1.amount.toString());
    expect(trxController.trx.amount == mockTrx1.amount, true);
  });

  testWidgets('Tap on date field should display date picker dialog', (tester) async {
    await tester.pumpGetApp(TrxScreen());
    await tester.tap(find.byKey(Key(Txt.date)));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsOneWidget);
  });

  testWidgets('Tap on category field should display dropdown list', (tester) async {
    await tester.pumpGetApp(TrxScreen());
    await tester.tap(find.byKey(Key(Txt.category)));
    await tester.pumpAndSettle();
    for (var category in Category.list) {
      expect(find.text(category.name), findsAtLeast(1));
    }
  });
}
