import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/data/repositories/home_repository_impl.dart';
import 'package:b2_people/src/models/basic_person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/persons.dart';

class DioMock extends Mock implements DioMixin {}

void main() {
  late Dio dio;
  late IHomeRepository repository;
  late FirebaseFirestore firestore;

  setUpAll(
    () {
      dio = DioMock();
      firestore = FakeFirebaseFirestore();
      repository = HomeRepositoryImpl(dio, firestore);
    },
  );

  group(
    'getPersons should',
    () {
      test(
        'fail with DioException, returning null for the list value, and a string containing the error message.',
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

          final (persons, error) = await repository.getPersons('seed', 1, 20);

          expect(persons, isNull);
          expect(error, equals('Ops! Algum erro ocorreu durante a busca.'));
        },
      );
      test(
        'fail with Exception, returning null for the list value, and a string containing the error message.',
        () async {
          when(() => dio.get(any())).thenThrow(Exception());
          final (persons, error) = await repository.getPersons('seed', 1, 20);

          expect(persons, isNull);
          expect(error, equals('Um erro inesperado ocorreu.'));
        },
      );
      test(
        'return a list of persons and a null string as error value',
        () async {
          when(() => dio.get(any())).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: personMapsResultsMock,
            ),
          );

          final (persons, error) = await repository.getPersons('seed', 1, 20);

          expect(persons, isNotNull);
          expect(persons, isNotEmpty);
          expect(error, isNull);
          expect(persons!.first, isA<BasicPersonModel>());
          expect(persons.first.fullName, equals('Jennie Nichols'));
        },
      );
    },
  );

  test(
    'return a list of persons and a null string as error value',
    () async {
      final (persons, error) = await repository.getSavedPersons();

      expect(persons, isNotNull);
      expect(error, isNull);
      expect(persons, isA<List<BasicPersonModel>>());
    },
  );
}
