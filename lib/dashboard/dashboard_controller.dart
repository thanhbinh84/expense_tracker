import 'package:expense_tracker/app/routes.dart';
import 'package:expense_tracker/core/controller/base_controller.dart';
import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final trxRepository = Get.find<TrxRepository>();
  List<Trx> trxList = [];
  final filteredTrxList = Rx<List<Trx>>([]);
  final category = Category.all.obs;

  @override
  onInit() {
    super.onInit();
    _getLatestTrxList();
  }

  _getLatestTrxList() async {
    try {
      loading();
      trxRepository.getTrxList().listen((event) {
        trxList = event;
        filterByCategory();
        success();
      });
    } catch (e) {
      error(error: e.toString());
    }
  }

  filterByCategory({Category? ca}) {
    if (ca != null) {
      category.value = ca;
      category.refresh();
    }
    if (category.value == Category.all) {
      filteredTrxList.value = trxList;
    } else {
      filteredTrxList.value = trxList.where((trx) => trx.category == category.value).toList();
    }
    filteredTrxList.refresh();
  }

  goToAddTrxScreen() => Get.toNamed(Routes.trx);
  goToSummaryScreen() => Get.toNamed(Routes.summary);
}
