import 'package:b2_people/src/views/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../mocks/users.dart';

void main() {
  group(
    'User page should',
    () {
      testWidgets(
        'should display user info successfully',
        (tester) async {
          final userPage = UserPage(user: user2Mock);

          await mockNetworkImagesFor(() async {
            await tester.pumpWidget(
              MaterialApp(
                home: userPage,
              ),
            );

            await tester.pumpAndSettle();

            expect(find.text(user2Mock.fullName), findsOneWidget);
          });
        },
      );
      testWidgets(
        'should activate the female user info bottom sheet',
        (tester) async {
          final userPage = UserPage(user: user1Mock);

          await mockNetworkImagesFor(() async {
            await tester.pumpWidget(
              MaterialApp(
                home: userPage,
              ),
            );

            await tester.pumpAndSettle();

            expect(find.text(user1Mock.fullName), findsOneWidget);

            final bottomSheetButton = find.byKey(const Key('bottom_sheet_button'));

            await tester.tap(bottomSheetButton);

            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.byKey(const Key('bottom_sheet')), findsOneWidget);
          });
        },
      );
      testWidgets(
        'should activate the user info bottom sheet',
        (tester) async {
          final userPage = UserPage(user: user2Mock);

          await mockNetworkImagesFor(() async {
            await tester.pumpWidget(
              MaterialApp(
                home: userPage,
              ),
            );

            await tester.pumpAndSettle();

            expect(find.text(user2Mock.fullName), findsOneWidget);

            final bottomSheetButton = find.byKey(const Key('bottom_sheet_button'));

            await tester.tap(bottomSheetButton);

            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.byKey(const Key('bottom_sheet')), findsOneWidget);
          });
        },
      );
    },
  );
}
