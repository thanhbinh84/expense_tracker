import 'package:expense_tracker/app/routes.dart';
import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class ManualMockDashboardController extends GetxController
    with Mock
    implements DashboardController {
  @override
  RxStatus get status => RxStatus.success();

  @override
  Rx<List<Trx>> get trxList => Rx<List<Trx>>([]);
}

class ManualMockTrxRepository extends GetxService with Mock implements TrxRepository {
  @override
  Stream<List<Trx>> getTrxList() {
    return Stream.value([]);
  }

  @override
  Future<void> saveTrx(Trx trx) {
    return Future(() => print('saveTrx'));
  }
}

extension PumpGetApp on WidgetTester {
  Future<void> pumpGetApp(Widget widget) async {
    await _setSurfaceSize(binding);
    return pumpWidget(GetMaterialApp(home: widget));
  }

  Future<void> pumpGetAppWithRoute(Widget widget) async {
    await _setSurfaceSize(binding);
    return pumpWidget(GetMaterialApp(
      getPages: Routes.routes,
      home: widget,
    ));
  }
}

_setSurfaceSize(binding) async => await binding.setSurfaceSize(Size(360, 780));

void initAppServices() {
  Get.put<TrxRepository>(ManualMockTrxRepository());
  Get.put<DashboardController>(ManualMockDashboardController());
}

final mockTrx1 =
    Trx(amount: 1, desc: 'desc1', dateTime: DateTime(2025, 1, 21), category: Category.food);
final mockTrx2 =
    Trx(amount: 2, desc: 'desc2', dateTime: DateTime(2025, 1, 21), category: Category.shopping);
final mockTrx3 =
    Trx(amount: 3, desc: 'desc3', dateTime: DateTime(2025, 1, 20), category: Category.travel);

final mockTrxList = [mockTrx1, mockTrx2, mockTrx3];
