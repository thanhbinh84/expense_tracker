import 'package:expense_tracker/core/model/trx.dart';

abstract class TrxApi {
  Stream<List<Trx>> getTrxList();
  Future<void> saveTrx(Trx trx);
}