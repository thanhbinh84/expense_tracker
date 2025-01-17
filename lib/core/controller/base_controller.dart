import 'package:expense_tracker/core/util/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BaseController extends GetxController with StateMixin {
  @override
  void onInit() {
    super.onInit();
    success();
  }

  loading() {
    change(null, status: RxStatus.loading());
  }
  success() {
    change(null, status: RxStatus.success());
  }
  error({String? error}) {
    if(error != null) {
      Utils.errorToast(error);
      if (kDebugMode) {
        print(error);
      }
    }
    change(null, status: RxStatus.error());
  }
}