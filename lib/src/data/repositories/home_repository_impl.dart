import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/models/basic_person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class HomeRepositoryImpl implements IHomeRepository {
  HomeRepositoryImpl(this._dio, this._firestore);

  final Dio _dio;
  final FirebaseFirestore _firestore;

  @override
  Future<(List<BasicPersonModel>?, String?)> getPersons(String seed, int page, int results) async {
    try {
      final List<BasicPersonModel> usersList = [];

      final response = await _dio.get('https://randomuser.me/api/?page=$page&results=$results&seed=$seed&inc=login,name,gender,email,nat,picture');
      final users = response.data['results'] as List;

      for (var item in users) {
        var userMap = item as Map<String, dynamic>;
        final user = BasicPersonModel.fromMap(userMap);

        user.addSeed(seed);

        usersList.add(user);
      }

      return (usersList, null);
    } on DioException catch (_) {
      return (null, 'Ops! Algum erro ocorreu durante a busca.');
    } catch (e) {
      return (null, 'Um erro inesperado ocorreu.');
    }
  }

  @override
  Future<(List<BasicPersonModel>?, String?)> getSavedPersons() async {
    try {
      final List<BasicPersonModel> preferedUsers = [];

      final favoriteesCollection = await _firestore.collection('base').get();
      final preferedProfilesDocs = favoriteesCollection.docs.toList();

      for (var user in preferedProfilesDocs) {
        final userMap = user.data();
        final preferedUser = BasicPersonModel.fromSavedMap(userMap);
        preferedUsers.add(preferedUser);
      }

      return (preferedUsers, null);
    } catch (e) {
      return (null, 'Erro ao obter lista de perfis favoritos.');
    }
  }
}
