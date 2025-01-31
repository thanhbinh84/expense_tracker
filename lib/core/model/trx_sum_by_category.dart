import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/util/const/txt.dart';

class TrxSumByCategory {
  Category category = Category.food;
  List<Trx> trxList = [];
  double totalAmountAllTrx = 0;

  TrxSumByCategory(this.category, this.trxList, this.totalAmountAllTrx);

  get totalTrxString =>
      '${trxList.length} ${trxList.length == 1 ? Txt.transaction : Txt.transactions}';

  get percentString => '${(totalAmount * 100 / totalAmountAllTrx).round()}%';

  double get totalAmount => trxList.fold(0.0, (sum, trx) => sum + trx.amount);

  get totalAmountString => '€$totalAmount';
}
