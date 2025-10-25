import 'package:b2_people/src/data/repositories/persons_repository_impl.dart';
import 'package:b2_people/src/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/persons.dart';
import 'home_repository_impl_test.dart';

void main() {
  late Dio dio;
  late FirebaseFirestore firebase;
  late PersonsRepositoryImpl repository;

  setUpAll(
    () {
      dio = DioMock();
      firebase = FakeFirebaseFirestore();
      repository = PersonsRepositoryImpl(dio, firebase);
    },
  );

  group(
    'fetchPerson should',
    () {
      test(
        'return a record with a null value and an error string message when person fetching fails',
        () async {
          when(() => dio.get(any())).thenThrow(
            DioException(
              response: Response(
                statusCode: 400,
                requestOptions: RequestOptions(),
              ),
              requestOptions: RequestOptions(),
            ),
          );

          final (users, error) = await repository.fetchPerson('seed');

          expect(users, isNull);
          expect(error, equals('Ops! Não foi possível obter informações do perfil selecionado.'));
        },
      );
      test(
        'fail with generic exception',
        () async {
          when(() => dio.get(any())).thenThrow(Exception());
          final (users, error) = await repository.fetchPerson('seed');

          expect(users, isNull);
          expect(error, equals('Um erro inesperado ocorreu.'));
        },
      );
      test(
        'return a record with a person object and a null value when person fetching completes successfully.',
        () async {
          when(() => dio.get(any())).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: personMapsResultsMock,
            ),
          );

          final (person, error) = await repository.fetchPerson('seed');

          expect(person, isNotNull);
          expect(person!.id, isNotEmpty);
          expect(person.name.first, equals('Jennie'));
          expect(person.name.last, equals('Nichols'));
          expect(error, isNull);
        },
      );
    },
  );

  test(
    'markUserAsPrefered should return true if user user is saved successfully',
    () async {
      final result = await repository.markPersonAsPrefered('accountEmail', personMock);

      expect(result, isTrue);
    },
  );

  test(
    'getPreferedPersons should retrieve a list of users previously marked as prefered (returns a List<PreferedUserModel>)',
    () async {
      final accountEmail = 'ownerpreference@email.com';
      final markResult = await repository.markPersonAsPrefered(accountEmail, personMock);

      expect(markResult, isTrue);

      final (result, errorString) = await repository.getPreferedPersons(accountEmail);

      expect(result, isA<List<PersonModel>>());
      expect(result, isNotEmpty);
      expect(errorString, isNull);
    },
  );

  test(
    'getPreferedPersons retrieve a list of users previously marked as prefered (returns a List<PreferedUserModel>)',
    () async {
      final accountEmail = 'ownerpreference@email.com';
      final markResult = await repository.markPersonAsPrefered(accountEmail, personMock);

      expect(markResult, isTrue);

      final (result, errorString) = await repository.getPreferedPersons(accountEmail);

      expect(result, isA<List<PersonModel>>());
      expect(result, isNotEmpty);
      expect(errorString, isNull);
    },
  );

  test(
    'verifyUserMark should return true if person is remove from preferences and false otherwise.',
    () async {
      final accountEmail = 'ownerpreference@email.com';
      final result = await repository.markPersonAsPrefered(accountEmail, personMock);

      expect(result, isTrue);

      final (usersResult, errorString) = await repository.getPreferedPersons(accountEmail);

      expect(usersResult, isA<List<PersonModel>>());
      expect(usersResult, isNotEmpty);
      expect(errorString, isNull);

      final hasMarkedAsFavorite = await repository.verifyPersonMark(personMock.id, accountEmail);

      expect(hasMarkedAsFavorite, isTrue);

      final hasBeenRemoved = await repository.removePreference(accountEmail, personMock);

      expect(hasBeenRemoved, isTrue);

      final hasMarkedAsFavoriteYet = await repository.verifyPersonMark(personMock.id, accountEmail);

      expect(hasMarkedAsFavoriteYet, isFalse);
    },
  );

  test(
    'removerPreference should return true to account owner that has selected the profile as favorite.',
    () async {
      final accountEmail = 'ownerpreference@email.com';
      final result = await repository.markPersonAsPrefered(accountEmail, personMock);

      expect(result, isTrue);

      final (usersResult, errorString) = await repository.getPreferedPersons('ownerpreference@email.com');

      expect(usersResult, isA<List<PersonModel>>());
      expect(usersResult, isNotEmpty);
      expect(errorString, isNull);

      final removingResult = await repository.removePreference(accountEmail, personMock);

      expect(removingResult, isTrue);

      final (removedUsersResult, _) = await repository.getPreferedPersons(accountEmail);

      expect(removedUsersResult, isA<List<PersonModel>>());
      expect(removedUsersResult, isEmpty);
    },
  );

  test(
    'getUserMarks should retrieve the amount of preferences of a single user (returns an int with the value)',
    () async {
      final accountEmail = 'ownerpreference@email.com';
      final markResult = await repository.markPersonAsPrefered(accountEmail, personMock1);

      expect(markResult, isTrue);

      final (result, errorString) = await repository.getPreferedPersons(accountEmail);

      expect(result, isA<List<PersonModel>>());
      expect(result, isNotEmpty);
      expect(errorString, isNull);

      final (markAmount, error) = await repository.getPersonMarks(personMock1.id);

      expect(markAmount, isA<int>());
      expect(markAmount, isNotNull);
      expect(markAmount, equals(1));
      expect(error, isNull);
    },
  );
}
