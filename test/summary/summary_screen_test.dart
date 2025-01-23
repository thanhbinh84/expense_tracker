import 'package:expense_tracker/core/model/calendar_filter.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:expense_tracker/summary/summary_controller.dart';
import 'package:expense_tracker/summary/summary_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../helper.dart';
import '../shared_mock.mocks.dart';

void main() {
  testWidgets('The total amount should be updated when calendar segment is selected',
      (tester) async {
    final trxRepository = Get.put<TrxRepository>(MockTrxRepository());
    when(trxRepository.getTrxList()).thenAnswer((_) => Stream.value(mockTrxList));
    Get.put(SummaryController());
    await tester.pumpGetApp(SummaryScreen());
    await tester.tap(find.text(CalendarFilter.month.name));
    await tester.pumpAndSettle();
    expect(find.textContaining('${mockTrx1.amount + mockTrx2.amount}', findRichText: true),
        findsAtLeast(1));
    await tester.tap(find.text(CalendarFilter.year.name));
    await tester.pumpAndSettle();
    expect(
        find.textContaining('${mockTrx1.amount + mockTrx2.amount + mockTrx3.amount}',
            findRichText: true),
        findsAtLeast(1));
  });

  testWidgets('Error should throw when cannot get trx list', (tester) async {
    Get.reset();
    final mockTrxRepository = Get.put<TrxRepository>(MockTrxRepository());
    when(mockTrxRepository.getTrxList()).thenThrow(Exception(''));
    final controller = Get.put(SummaryController());
    await tester.pumpGetApp(SummaryScreen());
    expect(controller.status.isError, true);
  });
}
