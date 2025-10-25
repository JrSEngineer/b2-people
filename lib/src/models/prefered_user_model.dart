// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:b2_people/src/models/person_gender.dart';

class PreferedUserModel {
  final String id;
  final String fullName;
  final String email;
  final PersonGender gender;
  final String profileImage;
  final String preferenceOwner;

  PreferedUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.profileImage,
    required this.preferenceOwner,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'gender': gender.name,
      'profileImage': profileImage,
      'preferenceOwner': preferenceOwner,
    };
  }

  factory PreferedUserModel.fromMap(Map<String, dynamic> map) {
    return PreferedUserModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      gender: map['gender'] == 'female' ? PersonGender.female : PersonGender.male,
      profileImage: map['profileImage'] as String,
      preferenceOwner: map['preferenceOwner'] as String,
    );
  }
}
