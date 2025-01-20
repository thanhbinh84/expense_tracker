import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:expense_tracker/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/trx/trx_controller.dart';
import 'package:expense_tracker/trx/trx_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const dashboard = '/dashboard';
  static const trx = '/trx';

  static final routes = [
    GetPage(name: dashboard, page: () => const DashboardScreen(), binding: DashboardBinding()),
    GetPage(name: trx, page: () => const TrxScreen(), binding: TrxBinding()),
  ];
}


class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}

class TrxBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TrxController());
  }
}
