import 'package:b2_people/src/models/prefered_user_model.dart';

abstract interface class IUsersRepository {
  Future<bool> markUserAsPrefered(PreferedUserModel user);
  Future<bool> verifyUserMark(String userId, String accountEmail);
  Future<bool> removePreference(PreferedUserModel user);
  Future<(List<PreferedUserModel>?, String?)> getPreferedUsers(String accountEmail);
  Future<(int?, String?)> getUserMarks(String userId);
}
