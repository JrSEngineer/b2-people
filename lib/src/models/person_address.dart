import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PersonAddress {
  final String streetName;
  final int streetNumber;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final String latitude;
  final String longitude;
  final String offset;
  final String description;

  PersonAddress({
    required this.streetName,
    required this.streetNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.latitude,
    required this.longitude,
    required this.offset,
    required this.description,
  });

  factory PersonAddress.fromMap(Map<String, dynamic> map) {
    return PersonAddress(
      streetName: map['street']['name'],
      streetNumber: map['street']['number'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      postcode: map['postcode'].toString(),
      latitude: map['coordinates']['latitude'],
      longitude: map['coordinates']['longitude'],
      offset: map['timezone']['offset'],
      description: map['timezone']['description'],
    );
  }

  factory PersonAddress.fromSavedMap(Map<String, dynamic> map) => PersonAddress(
    streetName: map['streetName'],
    streetNumber: map['streetNumber'],
    city: map['city'],
    state: map['state'],
    country: map['country'],
    postcode: map['postcode'].toString(),
    latitude: map['latitude'],
    longitude: map['longitude'],
    offset: map['offset'],
    description: map['description'],
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'streetName': streetName,
      'streetNumber': streetNumber,
      'city': city,
      'state': state,
      'country': country,
      'postcode': postcode,
      'latitude': latitude,
      'longitude': longitude,
      'offset': offset,
      'description': description,
    };
  }

  factory PersonAddress.empty() => PersonAddress(
    streetName: '',
    streetNumber: 0,
    city: '',
    state: '',
    country: '',
    postcode: '',
    latitude: '',
    longitude: '',
    offset: '',
    description: '',
  );

  String toJson() => json.encode(toMap());

  factory PersonAddress.fromJson(String source) => PersonAddress.fromMap(json.decode(source) as Map<String, dynamic>);
}
