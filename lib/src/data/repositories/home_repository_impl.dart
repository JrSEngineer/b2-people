import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/models/basic_person_model.dart';
import 'package:dio/dio.dart';

class HomeRepositoryImpl implements IHomeRepository {
  HomeRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<(List<BasicPersonModel>?, String?)> getUsers(String seed, int page, int results) async {
    try {
      final List<BasicPersonModel> usersList = [];

      final response = await _dio.get('https://randomuser.me/api/?page=$page&results=$results&seed=$seed&inc=login,name,gender,email,nat,picture');
      final users = response.data['results'] as List;

      for (var item in users) {
        var userMap = item as Map<String, dynamic>;
        final user = BasicPersonModel.fromMap(userMap);
        final usedSeed = response.data['info']['seed'] as String;

        user.addSeed(usedSeed);

        usersList.add(user);
      }

      return (usersList, null);
    } on DioException catch (_) {
      return (null, 'Ops! Algum erro ocorreu durante a busca.');
    } catch (e) {
      return (null, 'Um erro inesperado ocorreu.');
    }
  }
}
