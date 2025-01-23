import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:expense_tracker/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/summary/summary_controller.dart';
import 'package:expense_tracker/summary/summary_screen.dart';
import 'package:expense_tracker/trx/trx_controller.dart';
import 'package:expense_tracker/trx/trx_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const dashboard = '/dashboard';
  static const trx = '/trx';
  static const summary = '/summary';

  static final routes = [
    GetPage(name: dashboard, page: () => const DashboardScreen(), binding: DashboardBinding()),
    GetPage(name: trx, page: () => const TrxScreen(), binding: TrxBinding()),
    GetPage(name: summary, page: () => const SummaryScreen(), binding: SummaryBinding()),
  ];
}

class SummaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SummaryController());
  }
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
