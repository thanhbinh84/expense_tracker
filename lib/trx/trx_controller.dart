import 'package:expense_tracker/core/controller/base_controller.dart';
import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:get/get.dart';

class TrxController extends BaseController {
  static TrxController get to => Get.find();
  final trxRepository = Get.find<TrxRepository>();
  Trx trx = Trx(dateTime: DateTime.now());

  updateTrx({String? amount, String? desc, DateTime? dateTime}) {

    if (amount != null) {
      trx.amount = double.tryParse(amount) ?? 0;
    }
    if (desc != null) {
      trx.desc = desc;
    }
    if (dateTime != null) {
      trx.dateTime = dateTime;
    }
  }

  saveTrx() async {
    try {
      loading();
      await trxRepository.saveTrx(trx);
      success();
      Get.back();
    } catch (e) {
      error(error: e.toString());
    }
  }
}
