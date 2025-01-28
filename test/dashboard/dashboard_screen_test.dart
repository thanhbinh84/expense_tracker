import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:expense_tracker/core/util/const/txt.dart';
import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:expense_tracker/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/summary/summary_screen.dart';
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

  testWidgets('The summary button should route to the summary screen', (tester) async {
    Get.put<TrxRepository>(ManualMockTrxRepository());
    Get.put(DashboardController());
    await tester.pumpGetAppWithRoute(DashboardScreen());
    await tester.tap(find.byIcon(Icons.summarize));
    await tester.pumpAndSettle();
    expect(find.byType(SummaryScreen), findsOneWidget);
    expect(find.byType(DashboardScreen), findsNothing);
  });

  testWidgets('Allow users to filter expenses by category', (tester) async {
    Get.reset();
    final mockTrxRepository = Get.put<TrxRepository>(MockTrxRepository());
    when(mockTrxRepository.getTrxList()).thenAnswer((_) => Stream.value(mockTrxList));
    Get.put(DashboardController());
    await tester.pumpGetAppWithRoute(DashboardScreen());
    await tester.tap(find.byIcon(Icons.filter_list_rounded));
    await tester.pumpAndSettle();
    for (var category in Category.filterList) {
      expect(find.text(category.name), findsAtLeast(1));
    }
    final selectCategory = mockTrx2.category;
    await tester.tap(find.text(selectCategory.name).last);
    await tester.pump();
    expect(find.text(mockTrx2.desc), findsOneWidget);
    expect(find.text(mockTrx1.desc), findsNothing);
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
