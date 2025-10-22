import 'package:b2_people/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'App should select an user and navigate to user page.',
    (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byKey(const Key('home_page')), findsOneWidget);

      final firstUserTile = find.byKey(const Key('user_tile')).first;

      await tester.tap(firstUserTile);

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byKey(const Key('user_page')), findsOneWidget);
    },
  );
}
