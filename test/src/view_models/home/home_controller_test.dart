import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/data/repositories/home_repository_impl.dart';
import 'package:b2_people/src/models/basic_person_model.dart';
import 'package:b2_people/src/view_models/home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/persons.dart';

class HomeRepositoryMock extends Mock implements HomeRepositoryImpl {}

void main() {
  late IHomeRepository repository;
  late HomeController controller;

  setUpAll(
    () {
      repository = HomeRepositoryMock();
      controller = HomeController(repository);
    },
  );

  group(
    'fetchUsers should',
    () {
      test(
        'fail with DioException',
        () async {
          when(() => repository.getPersons(any(), any(), any())).thenAnswer((_) async => (<BasicPersonModel>[], 'Ops! Algum erro ocorreu durante a busca.'));

          await controller.fetchUsers();

          expect(controller.error.value, equals('Ops! Algum erro ocorreu durante a busca.'));
        },
      );
      test(
        'fail with different kind of Exception',
        () async {
          when(() => repository.getPersons(any(), any(), any())).thenAnswer((_) async => (<BasicPersonModel>[], 'Um erro inesperado ocorreu.'));

          await controller.fetchUsers();

          expect(controller.error.value, equals('Um erro inesperado ocorreu.'));
        },
      );
      test(
        'pass successfully filling up users list',
        () async {
          when(() => repository.getPersons(any(), any(), any())).thenAnswer((_) async => (personsList, null));

          await controller.fetchUsers();

          expect(controller.usersList.isNotEmpty, equals(true));
          expect(controller.usersList.length, equals(2));
          expect(controller.usersList.first, isA<BasicPersonModel>());
        },
      );
    },
  );
}
