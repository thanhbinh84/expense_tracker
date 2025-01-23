import 'package:expense_tracker/core/model/trx.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  test('Trx should decode and encode properly', () {
    final map = mockTrx1.toJson();
    expect(map[Trx.keyAmount], mockTrx1.amount);
    expect(map[Trx.keyCategoryIndex], mockTrx1.category.index);
    expect(map[Trx.keyDateTime], mockTrx1.dateString);
    expect(map[Trx.keyDesc], mockTrx1.desc);
    final trx = Trx.fromJson(map);
    expect(trx.desc, mockTrx1.desc);
    expect(trx.category.index, mockTrx1.category.index);
    expect(trx.dateString, mockTrx1.dateString);
    expect(trx.amount, mockTrx1.amount);
  });

  test('Category should be converted properly', () {
    for (Category category in Category.list) {
      expect(category, Category.getCategory(category.index));
    }
    expect(() => Category.getCategory(-1), throwsArgumentError);
  });
}