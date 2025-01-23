import 'package:expense_tracker/core/api/TrxApi.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../../helper.dart';
import '../../shared_mock.mocks.dart';

void main() {
  late TrxApi trxApi;
  late TrxRepository trxRepository;

  setUpAll(() async {
    Get.reset();
    trxApi = Get.put(MockTrxApi());
    trxRepository = Get.put(TrxRepository());
    when(trxApi.getTrxList()).thenAnswer((_) => Stream.value(mockTrxList));
    when(trxApi.saveTrx(mockTrx1)).thenAnswer((_) async {});
  });

  test('Trx repository should init properly', () async {
    expect(trxRepository, isNotNull);
  });

  test('Get transaction list should work properly', () async {
    expect(trxRepository.getTrxList(), emits(mockTrxList));
    verify(trxApi.getTrxList()).called(1);
  });

  test('Save transaction should work properly', () async {
    expect(trxRepository.saveTrx(mockTrx1), completes);
    verify(trxApi.saveTrx(mockTrx1)).called(1);
  });
}
