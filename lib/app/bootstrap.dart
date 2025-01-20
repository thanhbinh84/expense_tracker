import 'dart:async';

import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/core/api/LocalStorageTrxApi.dart';
import 'package:expense_tracker/core/api/TrxApi.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:expense_tracker/core/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void bootstrap() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initAppServices();
    runApp(const App());
  }, (e, s) => Utils.handleError(e, s: s));
}

_initAppServices() async {
  await Get.putAsync(() => SharedPreferences.getInstance(), permanent: true);
  Get.put<TrxApi>(LocalStorageTrxApi(), permanent: true);
  Get.put(TrxRepository(), permanent: true);
}
