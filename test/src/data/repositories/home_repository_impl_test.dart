import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/data/repositories/home_repository_impl.dart';
import 'package:b2_people/src/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/users.dart';

class DioMock extends Mock implements DioMixin {}

void main() {
  final String path = 'https://randomuser.me/api/?page=1&results=20&seed=seed';
  late Dio dio;
  late IHomeRepository repository;

  setUpAll(
    () {
      dio = DioMock();
      repository = HomeRepositoryImpl(dio);
    },
  );

  group(
    'getUsers should',
    () {
      test(
        'fail with DioException, returning null for the list value, and a string containing the error message.',
        () async {
          when(() => dio.get(path)).thenThrow(
            DioException(
              response: Response(
                statusCode: 400,
                requestOptions: RequestOptions(),
              ),
              requestOptions: RequestOptions(),
            ),
          );

          final (users, error) = await repository.getUsers('seed', 1, 20);

          expect(users, isNull);
          expect(error, equals('Ops! Algum erro ocorreu durante a busca.'));
        },
      );
      test(
        'fail with Exception, returning null for the list value, and a string containing the error message.',
        () async {
          when(() => dio.get(path)).thenThrow(Exception());
          final (users, error) = await repository.getUsers('seed', 1, 20);

          expect(users, isNull);
          expect(error, equals('Um erro inesperado ocorreu.'));
        },
      );
      test(
        'return a list of users and a null string as error value',
        () async {
          when(() => dio.get(path)).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: userMapsResultsMock,
            ),
          );

          final (users, error) = await repository.getUsers('seed', 1, 20);

          expect(users, isNotNull);
          expect(users, isNotEmpty);
          expect(error, isNull);
          expect(users!.first, isA<UserModel>());
          expect(users.first.fullName, equals('Jennie Nichols'));
        },
      );
    },
  );
}
