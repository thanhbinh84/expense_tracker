import 'package:expense_tracker/core/util/utils.dart';
import 'package:flutter/material.dart';

class Trx {
  double amount = 0;
  DateTime dateTime;
  String desc = '';
  Category category = Category.food;

  Trx({this.amount = 0, this.desc = '', DateTime? dateTime, this.category = Category.food})
      : dateTime = dateTime ?? DateTime.now();

  static const keyAmount = 'amount';
  static const keyDateTime = 'date';
  static const keyDesc = 'desc';
  static const keyCategoryIndex = 'category';

  Map<String, dynamic> toJson() => <String, dynamic>{
        keyAmount: amount,
        keyDateTime: utils.convertDateToString(dateTime),
        keyDesc: desc,
        keyCategoryIndex: category.index
      };

  factory Trx.fromJson(Map<String, dynamic> map) {
    return Trx(
      amount: map[keyAmount],
      dateTime: utils.convertStringToDate(map[keyDateTime]),
      desc: map[keyDesc],
      category: Category.getCategory(map[keyCategoryIndex])
    );
  }

  get dateString => utils.convertDateToString(dateTime);
  get amountString => '€${amount.toString()}';
}

class Category {
  final String name;
  final int index;
  final IconData iconData;

  const Category._internal(this.index, this.name, this.iconData);

  static const food = Category._internal(0, 'Food', Icons.food_bank);
  static const travel = Category._internal(1, 'Travel', Icons.flight);
  static const shopping = Category._internal(2, 'Shopping', Icons.shopping_bag);

  static const list = [food, travel, shopping];

  static Category getCategory(int index) {
    if (Category.food.index == index) {
      return Category.food;
    } else if (Category.travel.index == index) {
      return Category.travel;
    } else if (Category.shopping.index == index) {
      return Category.shopping;
    } else {
      throw ArgumentError();
    }
  }
}
