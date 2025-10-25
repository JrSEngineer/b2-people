class PersonAddress {
  final String streetName;
  final int streetNumber;
  final String city;
  final String state;
  final String country;
  final String postcode;

  PersonAddress({
    required this.streetName,
    required this.streetNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
  });

  factory PersonAddress.frommap(Map<String, dynamic> map) => PersonAddress(
    streetName: map['street']['name'],
    streetNumber: map['street']['number'],
    city: map['city'],
    state: map['state'],
    country: map['country'],
    postcode: map['postcode'].toString(),
  );

  factory PersonAddress.fromSavedMap(Map<String, dynamic> map) => PersonAddress(
    streetName: map['streetName'],
    streetNumber: map['streetNumber'],
    city: map['city'],
    state: map['state'],
    country: map['country'],
    postcode: map['postcode'].toString(),
  );

  Map<String, dynamic> toMap() => {
    'streetName': streetName,
    'streetNumber': streetNumber,
    'city': city,
    'state': state,
    'country': country,
    'postcode': postcode,
  };

  factory PersonAddress.empty() => PersonAddress(streetName: '', streetNumber: 0, city: '', state: '', country: '', postcode: '');
}
