import 'package:b2_people/src/data/interfaces/iusers_repository.dart';
import 'package:b2_people/src/models/person_model.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository(this._dio, this._firestore);

  final Dio _dio;
  final FirebaseFirestore _firestore;

  @override
  Future<(Person?, String?)> fetchPerson(String seed) async {
    try {
      final response = await _dio.get('https://randomuser.me/api/?seed=$seed');
      final personsList = response.data['results'] as List;

      final personMap = personsList.first as Map<String, dynamic>;

      final person = Person.frommap(personMap);

      return (person, null);
    } on DioException catch (_) {
      return (null, 'Ops! Não foi possível obter informações do perfil selecionado.');
    } catch (e) {
      return (null, 'Um erro inesperado ocorreu.');
    }
  }

  @override
  Future<bool> markUserAsPrefered(PreferedUserModel user) async {
    try {
      await _firestore.collection('profiles').doc(user.id).collection('marks').doc(user.preferenceOwner).set(user.toMap());
      await _firestore.collection('users').doc(user.preferenceOwner).collection('favorites').doc(user.id).set(user.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> removePreference(PreferedUserModel user) async {
    try {
      await _firestore.collection('profiles').doc(user.id).collection('marks').doc(user.preferenceOwner).delete();
      await _firestore.collection('users').doc(user.preferenceOwner).collection('favorites').doc(user.id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verifyUserMark(String userId, String accountEmail) async {
    try {
      final currentProfileMarkDocument = await _firestore.collection('profiles').doc(userId).collection('marks').doc(accountEmail).get();
      return currentProfileMarkDocument.exists;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<(List<PreferedUserModel>?, String?)> getPreferedUsers(String accountEmail) async {
    try {
      final List<PreferedUserModel> preferedUsers = [];

      final favoriteesCollection = await _firestore.collection('users').doc(accountEmail).collection('favorites').get();
      final preferedProfilesDocs = favoriteesCollection.docs.toList();

      for (var user in preferedProfilesDocs) {
        final userMap = user.data();
        final preferedUser = PreferedUserModel.fromMap(userMap);
        preferedUsers.add(preferedUser);
      }

      return (preferedUsers, null);
    } catch (e) {
      return (null, 'Erro ao obter lista de perfis favoritos.');
    }
  }

  @override
  Future<(int?, String?)> getUserMarks(String userId) async {
    try {
      final profileMarks = await _firestore.collection('profiles').doc(userId).collection('marks').get();

      final totalPreferences = profileMarks.docs.length;

      return (totalPreferences, null);
    } catch (e) {
      return (null, 'Erro ao obter marcações do usuário');
    }
  }
}
