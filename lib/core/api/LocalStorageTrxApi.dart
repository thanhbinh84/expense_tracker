import 'dart:convert';

import 'package:expense_tracker/core/api/TrxApi.dart';
import 'package:expense_tracker/core/model/trx.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageTrxApi extends GetxService implements TrxApi {
  static const keyTrxListJson = 'keyTrxListJson';
  final _sharedPreferences = Get.find<SharedPreferences>();
  final _trxListStreamController = BehaviorSubject<List<Trx>>.seeded([]);

  @override
  void onInit() {
    final trxListJson = _sharedPreferences.getString(keyTrxListJson);
    if (trxListJson != null) {
      final trxList = (json.decode(trxListJson) as List).map((e) => Trx.fromJson(e)).toList();
      _trxListStreamController.add(trxList);
    }
    super.onInit();
  }

  @override
  Stream<List<Trx>> getTrxList() => _trxListStreamController.asBroadcastStream();

  @override
  Future<void> saveTrx(Trx trx) {
    final trxList = _trxListStreamController.value;
    trxList.add(trx);
    _trxListStreamController.add(trxList);
    return _sharedPreferences.setString(keyTrxListJson, json.encode(trxList));
  }

  @override
  void onClose() {
    _trxListStreamController.close();
    super.onClose();
  }
}
