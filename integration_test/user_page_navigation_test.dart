import 'package:b2_people/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'App should select an user and navigate to user page.',
    (tester) async {
      await app.main();

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byKey(const Key('auth_page')), findsOneWidget);

      await tester.pump();

      final authButton = find.byKey(const Key('auth_button'));

      await tester.tap(authButton);

      await tester.pump();

      await tester.pump(const Duration(seconds: 12));

      await tester.pump();

      expect(find.byKey(const Key('home_page')), findsOneWidget);

      await tester.pump(const Duration(seconds: 5));

      await tester.pumpAndSettle();

      final tickerControllerButton = find.byIcon(Icons.pause);

      await tester.pump(const Duration(seconds: 5));

      await tester.tap(tickerControllerButton);

      await tester.pumpAndSettle();

      final firstUserTile = find.byKey(const Key('user_tile')).first;

      await tester.tap(firstUserTile);

      await tester.pump();

      await tester.pump(const Duration(seconds: 1));

      expect(find.byKey(const Key('user_page')), findsOneWidget);
    },
  );
}
