import 'dart:async';

import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/core/repository/workout_repository.dart';
import 'package:expense_tracker/core/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bootstrap() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initAppServices();
    runApp(const App());
  }, (e, s) => Utils.handleError(e, s: s));
}

_initAppServices() async {
  Get.put(TrxRepository(), permanent: true);
}
