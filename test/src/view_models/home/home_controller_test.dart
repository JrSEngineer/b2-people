import 'package:b2_people/src/models/user_model.dart';
import 'package:b2_people/src/view_models/home/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/users.dart';

class DioMock extends Mock implements DioMixin {}

void main() {
  final String path = 'https://randomuser.me/api/?page=1&results=20&seed=myusers';
  late Dio dio;
  late HomeController controller;

  setUpAll(
    () {
      dio = DioMock();
      controller = HomeController(dio);
    },
  );

  group(
    'fetchUsers should',
    () {
      test(
        'fail with DioException',
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

          await controller.fetchUsers();

          expect(controller.error.value, equals('Ops! Algum erro ocorreu durante a busca.'));
        },
      );
      test(
        'fail with different kind of Exception',
        () async {
          when(() => dio.get(path)).thenThrow(Exception());

          await controller.fetchUsers();

          expect(controller.error.value, equals('Um erro inesperado ocorreu.'));
        },
      );
      test(
        'pass successfully filling up users list',
        () async {
          when(() => dio.get(path)).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: userMapsResultsMock,
            ),
          );

          await controller.fetchUsers();

          expect(controller.usersList.isNotEmpty, equals(true));
          expect(controller.usersList.length, equals(2));
          expect(controller.usersList.first, isA<UserModel>());
        },
      );
    },
  );
}
