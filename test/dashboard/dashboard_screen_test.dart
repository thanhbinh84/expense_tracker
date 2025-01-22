import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:expense_tracker/core/util/const/txt.dart';
import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:expense_tracker/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/trx/trx_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../helper.dart';
import '../shared_mock.mocks.dart';

void main() {
  testWidgets('Show no transaction history for empty transaction', (tester) async {
    Get.put<TrxRepository>(ManualMockTrxRepository());
    Get.put(DashboardController());
    await tester.pumpGetApp(DashboardScreen());
    final textFinder = find.text(Txt.noTransactionHistory);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('The floating add button should be visual', (tester) async {
    Get.put<TrxRepository>(ManualMockTrxRepository());
    Get.put(DashboardController());
    await tester.pumpGetApp(DashboardScreen());
    final addButton = tester.widget(find.byType(FloatingActionButton)) as FloatingActionButton;
    final addButtonIcon = addButton.child as Icon;
    expect(addButton, isNotNull);
    expect(addButtonIcon.icon == Icons.add, true);
  });

  testWidgets('The add button should route to the transaction screen', (tester) async {
    Get.put<TrxRepository>(ManualMockTrxRepository());
    Get.put(DashboardController());
    await tester.pumpGetAppWithRoute(DashboardScreen());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(TrxScreen), findsOneWidget);
    expect(find.byType(DashboardScreen), findsNothing);
  });

  testWidgets('Display a list of expenses grouped by day', (tester) async {
    Get.reset();
    final mockTrxRepository = Get.put<TrxRepository>(MockTrxRepository());
    when(mockTrxRepository.getTrxList()).thenAnswer((_) => Stream.value(mockTrxList));
    Get.put(DashboardController());
    await tester.pumpGetApp(DashboardScreen());
    expect(find.text(mockTrx1.dateString), findsOneWidget);
    expect(find.text(mockTrx2.dateString), findsOneWidget);
  });

  testWidgets('Item list should show amount, description and category by icon', (tester) async {
    Get.reset();
    final mockTrxRepository = Get.put<TrxRepository>(MockTrxRepository());
    when(mockTrxRepository.getTrxList()).thenAnswer((_) => Stream.value(mockTrxList));
    Get.put(DashboardController());
    await tester.pumpGetApp(DashboardScreen());
    expect(find.text(mockTrx1.desc), findsOneWidget);
    expect(find.text(mockTrx1.amountString), findsOneWidget);
    expect(find.byIcon(mockTrx1.category.iconData), findsAtLeast(1));
  });

  testWidgets('Error should throw when cannot get trx list', (tester) async {
    Get.reset();
    final mockTrxRepository = Get.put<TrxRepository>(MockTrxRepository());
    when(mockTrxRepository.getTrxList()).thenThrow(Exception(''));
    final controller = Get.put(DashboardController());
    await tester.pumpGetApp(DashboardScreen());
    expect(controller.status.isError, true);
  });
}
