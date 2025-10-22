import 'package:b2_people/src/models/user_model.dart';

abstract interface class IHomeRepository {
  Future<(List<UserModel>?, String?)> getUsers(String seed, int page, int results);
}
