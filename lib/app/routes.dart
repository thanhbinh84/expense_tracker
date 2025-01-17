import 'package:expense_tracker/dashboard/dashboard_controller.dart';
import 'package:expense_tracker/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const dashboard = '/dashboard';

  static final routes = [
    GetPage(name: dashboard, page: () => const DashboardScreen(), binding: DashboardBinding()),
  ];
}


class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
