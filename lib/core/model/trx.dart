import 'package:expense_tracker/core/util/utils.dart';

class Trx {
  double amount = 0;
  DateTime dateTime;
  String desc = '';

  Trx({this.amount = 0, this.desc = '', DateTime? dateTime})
      : dateTime = dateTime ?? DateTime.now();

  static const keyAmount = 'amount';
  static const keyDateTime = 'date';
  static const keyDesc = 'desc';

  Map<String, dynamic> toJson() => <String, dynamic>{
        keyAmount: amount,
        keyDateTime: utils.convertDateToString(dateTime),
        keyDesc: desc,
      };

  factory Trx.fromJson(Map<String, dynamic> map) {
    return Trx(
      amount: map[keyAmount],
      dateTime: utils.convertStringToDate(map[keyDateTime]),
      desc: map[keyDesc],
    );
  }

  get dateString => utils.convertDateToString(dateTime);
}
