import 'package:b2_people/src/data/interfaces/iauth_repository.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late IAuthRepository repository;
  late AuthController controller;

  setUpAll(
    () {
      repository = AuthRepositoryMock();
      controller = AuthController(repository);
    },
  );

  tearDown(
    () {
      controller.error.value = '';
    },
  );

  group('signInWithGoogle should', () {
    test(
      'fail to authenticate user',
      () async {
        when(() => repository.signInWithGoogle()).thenAnswer((_) async => 'Falha na autenticação.');

        await controller.signInWithGoogle();

        expect(controller.error.value, isNotEmpty);
        expect(controller.error.value, equals('Falha na autenticação.'));
        expect(controller.isOnline.value, equals(false));
      },
    );
    test(
      'authenticate user successfully',
      () async {
        when(() => repository.signInWithGoogle()).thenAnswer((_) async => null);

        await controller.signInWithGoogle();

        expect(controller.error.value, isEmpty);
        expect(controller.isOnline.value, equals(true));
      },
    );
  });

  test(
    'change user state to offline (isOnline: false)',
    () async {
      when(() => repository.signOut()).thenAnswer((_) async => Future.value());

      await controller.signOut();

      expect(controller.isOnline.value, equals(false));
    },
  );
}
