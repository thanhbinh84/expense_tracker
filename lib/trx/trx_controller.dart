import 'package:expense_tracker/core/controller/base_controller.dart';
import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TrxController extends BaseController {
  final trxRepository = Get.find<TrxRepository>();
  Trx trx = Trx();
  final dateInputController = TextEditingController();
  final categoryInputController = TextEditingController();

  @override
  onInit() {
    super.onInit();
    dateInputController.text = trx.dateString;
    categoryInputController.text = trx.category.name;
  }

  updateTrx({String? amount, String? desc, DateTime? dateTime, Category? category}) {

    if (amount != null) {
      trx.amount = double.tryParse(amount) ?? 0;
    }
    if (desc != null) {
      trx.desc = desc;
    }
    if (dateTime != null) {
      trx.dateTime = dateTime;
      dateInputController.text = trx.dateString;
    }
    if (category != null) {
      trx.category = category;
      categoryInputController.text = category.name;
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
