import 'package:b2_people/src/models/date_of_birthday.dart';
import 'package:b2_people/src/models/login_info.dart';
import 'package:b2_people/src/models/person_address.dart';
import 'package:b2_people/src/models/person_gender.dart';
import 'package:b2_people/src/models/person_identifier.dart';
import 'package:b2_people/src/models/person_name.dart';
import 'package:b2_people/src/models/registration_info.dart';

class PersonModel {
  final String id;
  final PersonName name;
  final PersonAddress address;
  final String email;
  final PersonGender gender;
  final LoginInfo login;
  final DateOfBirthday dateOfBirthday;
  final RegistrationInfo registered;
  final String phone;
  final String cell;
  final PersonIdentifier identifier;
  final String profileImage;
  final String naturallity;
  String usedSeed;

  PersonModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.gender,
    required this.login,
    required this.dateOfBirthday,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.identifier,
    required this.profileImage,
    required this.naturallity,
    required this.usedSeed,
  });

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    final genderStringValue = map['gender'];

    final gender = switch (genderStringValue) {
      'female' => PersonGender.female,
      'male' => PersonGender.male,
      _ => PersonGender.female,
    };

    return PersonModel(
      id: map['login']['uuid'],
      name: PersonName.fromMap(map['name']),
      address: PersonAddress.fromMap(map['location']),
      email: map['email'],
      gender: gender,
      login: LoginInfo.fromMap(map['login']),
      dateOfBirthday: DateOfBirthday.fromMap(map['dob']),
      registered: RegistrationInfo.fromMap(map['registered']),
      phone: map['phone'],
      cell: map['cell'],
      identifier: PersonIdentifier.fromMap(map['id']),
      profileImage: map['picture']['large'],
      naturallity: map['nat'],
      usedSeed: '',
    );
  }

  factory PersonModel.fromSavedMap(Map<String, dynamic> map) {
    return PersonModel(
      id: map['id'],
      name: PersonName.fromMap(map['name']),
      address: PersonAddress.fromSavedMap(map['address']),
      email: map['email'],
      gender: map['gender'] == 'female' ? PersonGender.female : PersonGender.male,
      login: LoginInfo.fromMap(map['login']),
      dateOfBirthday: DateOfBirthday.fromMap(map['dateOfBirthday']),
      registered: RegistrationInfo.fromMap(map['registered']),
      phone: map['phone'],
      cell: map['cell'],
      identifier: PersonIdentifier.fromMap(map['identifier']),
      profileImage: map['profileImage'],
      naturallity: map['naturallity'],
      usedSeed: map['usedSeed'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name.toMap(),
    'address': address.toMap(),
    'email': email,
    'login': login.toMap(),
    'dateOfBirthday': dateOfBirthday.toMap(),
    'registered': registered.toMap(),
    'gender': gender.name,
    'phone': phone,
    'cell': cell,
    'identifier': identifier.toMap(),
    'profileImage': profileImage,
    'naturallity': naturallity,
    'usedSeed': usedSeed,
  };

  factory PersonModel.empty() {
    return PersonModel(
      id: '',
      name: PersonName.empty(),
      address: PersonAddress.empty(),
      email: '',
      gender: PersonGender.male,
      login: LoginInfo.empty(),
      dateOfBirthday: DateOfBirthday.empty(),
      registered: RegistrationInfo.empty(),
      phone: '',
      cell: '',
      identifier: PersonIdentifier(name: ''),
      profileImage: '',
      naturallity: '',
      usedSeed: '',
    );
  }

  void addSeed(String seed) {
    usedSeed = seed;
  }
}
