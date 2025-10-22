class AddressModel {
  final String naturallity;
  final String postcode;
  final String city;
  final String state;
  final String country;

  AddressModel({
    required this.naturallity,
    required this.postcode,
    required this.city,
    required this.state,
    required this.country,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      naturallity: map['nat'],
      postcode: map['location']['postcode'].toString(),
      city: map['location']['city'],
      state: map['location']['state'],
      country: map['location']['country'],
    );
  }
}
