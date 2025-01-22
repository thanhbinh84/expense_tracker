import 'package:expense_tracker/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper.dart';

void main() {
  testWidgets('App should be loaded properly', (tester) async {
    initAppServices();
    await tester.pumpWidget(App());
  });
}