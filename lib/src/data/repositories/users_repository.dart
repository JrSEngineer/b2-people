import 'package:b2_people/src/data/interfaces/iusers_repository.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository(this._firestore);

  final FirebaseFirestore _firestore;

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
