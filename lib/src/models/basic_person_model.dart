// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/user_model.dart';

class BasicPersonModel {
  final String id;
  String usedSeed;
  final String fullName;
  final UserGender gender;
  final String email;
  final String naturallity;
  final String profileImage;

  BasicPersonModel({
    required this.id,
    required this.usedSeed,
    required this.fullName,
    required this.gender,
    required this.email,
    required this.naturallity,
    required this.profileImage,
  });

  factory BasicPersonModel.fromMap(Map<String, dynamic> map) {
    final genderStringValue = map['gender'];

    final gender = switch (genderStringValue) {
      'female' => UserGender.female,
      'male' => UserGender.male,
      _ => UserGender.female,
    };

    return BasicPersonModel(
      id: map['login']['uuid'],
      usedSeed: '',
      fullName: '${map['name']['first']} ${map['name']['last']}',
      gender: gender,
      email: map['email'],
      naturallity: map['nat'],
      profileImage: map['picture']['large'],
    );
  }

  void addSeed(String seed) {
    usedSeed = seed;
  }
}
