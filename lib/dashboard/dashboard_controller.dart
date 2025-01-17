import 'package:expense_tracker/core/controller/base_controller.dart';
import 'package:expense_tracker/core/repository/workout_repository.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  static DashboardController get to => Get.find();
  final trxRepository = Get.find<TrxRepository>();
  final trxList = [].obs;

  @override
  onInit() {
    super.onInit();
    _getTrxList();
  }

  _getTrxList() async {
    try {
      loading();
      trxList.value = await trxRepository.getTrxList();
      trxList.refresh();
      success();
    } catch (e) {
      error(error: e.toString());
    }
  }
}
