import 'package:b2_people/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'App should reach home page and load users list',
    (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byKey(const Key('home_page')), findsOneWidget);
    },
  );
}
