import 'package:expense_tracker/app/routes.dart';
import 'package:expense_tracker/core/controller/base_controller.dart';
import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final trxRepository = Get.find<TrxRepository>();
  final trxList = Rx<List<Trx>>([]);

  @override
  onInit() {
    super.onInit();
    _getLatestTrxList();
  }

  _getLatestTrxList() async {
    try {
      loading();
      trxRepository.getTrxList().listen((event) {
        trxList.value = event;
        trxList.refresh();
        success();
      });
    } catch (e) {
      error(error: e.toString());
    }
  }

  goToAddTrxScreen() => Get.toNamed(Routes.trx);
}
