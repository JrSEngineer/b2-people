import 'package:b2_people/src/models/address_model.dart';
import 'package:b2_people/src/models/profile_model.dart';

class UserModel {
  final String id;
  final String fullName;
  final UserGender gender;
  final ProfileModel profile;
  final AddressModel address;

  UserModel({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.profile,
    required this.address,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final genderStringValue = map['gender'];

    final gender = switch (genderStringValue) {
      'female' => UserGender.female,
      'male' => UserGender.male,
      _ => UserGender.female,
    };

    return UserModel(
      id: map['login']['uuid'],
      fullName: '${map['name']['first']} ${map['name']['last']}',
      gender: gender,
      profile: ProfileModel.fromMap(map),
      address: AddressModel.fromMap(map),
    );
  }
}

enum UserGender { female, male }
