import 'package:b2_people/src/data/interfaces/iusers_repository.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<bool> markUserAsPrefered(PreferedUserModel user) async {
    try {
      await _firestore.collection('profiles').doc(user.id).set(user.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> removePreference(PreferedUserModel user) async {
    try {
      await _firestore.collection('profiles').doc(user.id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<(List<PreferedUserModel>?, String?)> getPreferedUsers(String accountEmail) async {
    try {
      final List<PreferedUserModel> preferedUsers = [];

      final profilesCollection = await _firestore.collection('profiles').get();
      final preferedUsersDocs = profilesCollection.docs.where((doc) {
        return doc.data()['preferenceOwner'] == accountEmail;
      }).toList();

      for (var user in preferedUsersDocs) {
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
      final profilesCollection = await _firestore.collection('profiles').get();
      final preferedUsersDocs = profilesCollection.docs.where((doc) {
        return doc.data()['id'] == userId;
      }).toList();

      final totalPreferences = preferedUsersDocs.length;

      return (totalPreferences, null);
    } catch (e) {
      return (null, 'Erro ao obter marcações do usuário');
    }
  }
}
