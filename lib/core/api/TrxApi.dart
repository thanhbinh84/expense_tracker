import 'package:expense_tracker/core/model/trx.dart';

abstract class TrxApi {
  const TrxApi();
  Stream<List<Trx>> getTrxList();
  Future<void> saveTrx(Trx trx);
}