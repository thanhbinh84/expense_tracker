import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:expense_tracker/core/util/const/txt.dart';
import 'package:expense_tracker/core/util/utils.dart';
import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:expense_tracker/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/trx/trx_controller.dart';
import 'package:expense_tracker/trx/trx_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../helper.dart';
import '../shared_mock.mocks.dart';

void main() {
  late TrxController trxController;
  setUp(() {
    Get.put<TrxRepository>(ManualMockTrxRepository());
    trxController = Get.put(TrxController());
  });

  testWidgets('The screen displays description, amount, date, category and save button',
      (tester) async {
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

  testWidgets('Date field should be selectable via date picker dialog', (tester) async {
    await tester.pumpGetApp(TrxScreen());
    await tester.tap(find.byKey(Key(Txt.date)));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsOneWidget);
    // Tap OK on date picker dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text(utils.convertDateToString(DateTime.now())), findsOneWidget);
  });

  testWidgets('Category field should be selectable via dropdown field', (tester) async {
    await tester.pumpGetApp(TrxScreen());
    await tester.tap(find.byKey(Key(Txt.category)));
    await tester.pumpAndSettle();
    for (var category in Category.list) {
      expect(find.text(category.name), findsAtLeast(1));
    }
    final selectCategory = Category.list.last;
    await tester.tap(find.text(selectCategory.name).last);
    await tester.pumpAndSettle();
    expect(find.text(selectCategory.name), findsAtLeast(1));
  });

  testWidgets('Save button should route the dashboard screen', (tester) async {
    Get.put<TrxRepository>(ManualMockTrxRepository());
    Get.put(DashboardController());
    await tester.pumpGetAppWithRoute(DashboardScreen());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(Key(Txt.description)), mockTrx1.desc);
    await tester.enterText(find.byKey(Key(Txt.amount)), mockTrx1.amount.toString());
    await tester.tap(find.byKey(Key(Txt.save)));
    await tester.pumpAndSettle();
    expect(find.byType(TrxScreen), findsNothing);
  });

  testWidgets('Error messages should display for wrong input', (tester) async {
    await tester.pumpGetApp(TrxScreen());
    await tester.tap(find.byKey(Key(Txt.save)));
    await tester.pumpAndSettle();
    expect(find.text(Txt.pleaseEnterAmount), findsOne);
    expect(find.text(Txt.pleaseEnterDescription), findsOne);
  });

  testWidgets('Error should throw when saving goes wrong', (tester) async {
    Get.reset();
    final mockTrxRepository = Get.put<TrxRepository>(MockTrxRepository());
    when(mockTrxRepository.saveTrx(mockTrx1)).thenThrow(Exception(''));
    final controller = Get.put(TrxController());
    await tester.pumpGetApp(TrxScreen());
    await tester.enterText(find.byKey(Key(Txt.description)), mockTrx1.desc);
    await tester.enterText(find.byKey(Key(Txt.amount)), mockTrx1.amount.toString());
    controller.trx = mockTrx1;
    await tester.tap(find.byKey(Key(Txt.save)));
    await tester.pumpAndSettle();
    expect(controller.status.isError, true);
  });
}
