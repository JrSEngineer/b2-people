import 'package:b2_people/src/models/date_of_birthday.dart';
import 'package:b2_people/src/models/login_info.dart';
import 'package:b2_people/src/models/person_address.dart';
import 'package:b2_people/src/models/person_gender.dart';
import 'package:b2_people/src/models/person_identifier.dart';
import 'package:b2_people/src/models/person_name.dart';
import 'package:b2_people/src/models/registration_info.dart';

class Person {
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

  Person({
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
  });

  factory Person.frommap(Map<String, dynamic> map) {
    final genderStringValue = map['gender'];

    final gender = switch (genderStringValue) {
      'female' => PersonGender.female,
      'male' => PersonGender.male,
      _ => PersonGender.female,
    };

    return Person(
      id: map['login']['uuid'],
      name: PersonName.frommap(map['name']),
      address: PersonAddress.frommap(map['location']),
      email: map['email'],
      gender: gender,
      login: LoginInfo.frommap(map['login']),
      dateOfBirthday: DateOfBirthday.frommap(map['dob']),
      registered: RegistrationInfo.frommap(map['registered']),
      phone: map['phone'],
      cell: map['cell'],
      identifier: PersonIdentifier.frommap(map['id']),
      profileImage: map['picture']['large'],
    );
  }

  Map<String, dynamic> tomap() => {
    'id': id,
    'name': name.tomap(),
    'address': address.tomap(),
    'email': email,
    'login': login.tomap(),
    'dateOfBirthday': dateOfBirthday.tomap(),
    'registered': registered.tomap(),
    'phone': phone,
    'cell': cell,
    'identifier': identifier.tomap(),
    'profileImage': profileImage,
  };
}
