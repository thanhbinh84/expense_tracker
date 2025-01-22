import 'package:expense_tracker/core/api/TrxApi.dart';
import 'package:expense_tracker/core/model/trx.dart';
import 'package:get/get.dart';

class TrxRepository {
  final trxApi = Get.find<TrxApi>();

  Stream<List<Trx>> getTrxList() => trxApi.getTrxList();

  Future<void> saveTrx(Trx trx) => trxApi.saveTrx(trx);
}
