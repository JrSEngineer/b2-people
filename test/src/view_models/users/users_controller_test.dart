import 'package:b2_people/src/data/interfaces/iusers_repository.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:b2_people/src/view_models/users/users_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/users.dart';

class UsersRepositoryMock extends Mock implements IUsersRepository {}

void main() {
  late IUsersRepository repository;
  late UsersController controller;

  setUpAll(
    () {
      repository = UsersRepositoryMock();
      controller = UsersController(repository);
    },
  );

  tearDown(
    () {
      controller.error.value = '';
      controller.success.value = '';
    },
  );

  group(
    'fetchPerson should',
    () {
      test(
        'notify when person fetching fails',
        () async {
          when(() => repository.fetchPerson(any())).thenAnswer((_) async => (null, 'Mensagem de erro'));

          await controller.fetchPerson('seed');

          expect(controller.error.value, isNotEmpty);
          expect(controller.error.value, equals('Mensagem de erro'));
          expect(controller.person.value.id, isEmpty);
        },
      );

      test(
        'notify when person fetching completes successfully',
        () async {
          when(() => repository.fetchPerson(any())).thenAnswer(
            (_) async => (personMock, null),
          );

          await controller.fetchPerson('seed');

          expect(controller.person.value.id, isNotEmpty);
        },
      );
    },
  );
  group(
    'markUserAsPrefered should',
    () {
      test(
        'notify when a preference not occurs as expected (updates "error" value)',
        () async {
          when(() => repository.markUserAsPrefered(preferedUser)).thenAnswer((_) async => (false));

          await controller.markUserAsPrefered(preferedUser);

          expect(controller.error.value, isNotEmpty);
          expect(controller.error.value, equals('Erro ao favoritar perfil de usuário.'));
          expect(controller.success.value, isEmpty);
        },
      );

      test(
        'notify when a preference is set successfully (updates "success" value)',
        () async {
          when(() => repository.markUserAsPrefered(preferedUser)).thenAnswer((_) async => (true));

          await controller.markUserAsPrefered(preferedUser);

          expect(controller.success.value, isNotEmpty);
          expect(controller.success.value, equals('Perfil de usuário marcado como favorito.'));
          expect(controller.error.value, isEmpty);
        },
      );
    },
  );
  group(
    'removePreference should',
    () {
      test(
        'notify when a preference is not removed (updates "error" value)',
        () async {
          when(() => repository.removePreference(preferedUser)).thenAnswer((_) async => (false));

          await controller.removePreference(preferedUser);

          expect(controller.error.value, isNotEmpty);
          expect(controller.error.value, equals('Erro ao remover preferência.'));
          expect(controller.success.value, isEmpty);
        },
      );

      test(
        'notify when a preference is removed successfully (updates "success" value)',
        () async {
          when(() => repository.removePreference(preferedUser)).thenAnswer((_) async => (true));

          await controller.removePreference(preferedUser);

          expect(controller.success.value, isNotEmpty);
          expect(controller.success.value, equals('Preferência de perfil removida.'));
          expect(controller.error.value, isEmpty);
        },
      );
    },
  );

  group(
    'getPreferedUsers should',
    () {
      test(
        'notify when prefered users fetching fails (return a record with null value and error string message)',
        () async {
          when(() => repository.getPreferedUsers(any())).thenAnswer((_) async => (null, 'Erro ao obter perfis marcados como favoritos.'));

          await controller.getPreferedUsers('user@email.com');

          expect(controller.error.value, isNotEmpty);
          expect(controller.error.value, equals('Erro ao obter perfis marcados como favoritos.'));
          expect(controller.preferedUsersList, isEmpty);
        },
      );

      test(
        'retrieve favorite profiles successfully (adds up fetched users to preferedUsersList)',
        () async {
          when(() => repository.getPreferedUsers(any())).thenAnswer((_) async => (preferedUsersListMock, null));

          await controller.getPreferedUsers('user@email.com');

          expect(controller.error.value, isEmpty);
          expect(controller.preferedUsersList, isNotEmpty);
          expect(controller.preferedUsersList.length, equals(2));
          expect(controller.preferedUsersList, isA<List<PreferedUserModel>>());
          expect(controller.preferedUsersList.first, isA<PreferedUserModel>());
        },
      );
    },
  );
  group(
    'getUserMarks should',
    () {
      test(
        'notify when a profile preferences is not obtained (return a record with null value and error string message)',
        () async {
          when(() => repository.getUserMarks(any())).thenAnswer((_) async => (null, 'Erro ao obter marcações do usuário'));

          await controller.getUserMarks('user@email.com');

          expect(controller.error.value, isNotEmpty);
          expect(controller.error.value, equals('Erro ao obter marcações do usuário'));
          expect(controller.profileMarks.value, equals(0));
        },
      );

      test(
        'notify when a profile preferences are recovered successfully (updates "success" value)',
        () async {
          when(() => repository.getUserMarks(any())).thenAnswer((_) async => (2, null));

          await controller.getUserMarks('user@email.com');

          expect(controller.error.value, isEmpty);
          expect(controller.profileMarks.value, equals(2));
        },
      );
    },
  );
}
