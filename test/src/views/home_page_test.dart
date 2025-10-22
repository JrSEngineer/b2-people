import 'package:b2_people/src/app_module.dart';
import 'package:b2_people/src/app_widget.dart';
import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/views/home_page.dart';
import 'package:b2_people/src/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/users.dart';
import '../view_models/home/home_controller_test.dart';

void main() {
  late HomeRepositoryMock repository;

  setUpAll(
    () {
      repository = HomeRepositoryMock();
      when(() => repository.getUsers('myusers', 1, 20)).thenAnswer((_) async => (usersList, null));

      Modular.replaceInstance<IHomeRepository>(repository);
    },
  );
  testWidgets(
    'home page should list users right after load content from API.',
    (tester) async {
      await tester.pumpWidget(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );

      await tester.pump();
      expect(find.byType(SplashPage), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('user_list')), findsOneWidget);
    },
  );
}
