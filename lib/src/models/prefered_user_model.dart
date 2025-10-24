// ignore_for_file: public_member_api_docs, sort_constructors_first

class PreferedUserModel {
  final String id;
  final String fullName;
  final String email;
  final String profileImage;
  final String preferenceOwner;

  PreferedUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.preferenceOwner,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'profileImage': profileImage,
      'preferenceOwner': preferenceOwner,
    };
  }

  factory PreferedUserModel.fromMap(Map<String, dynamic> map) {
    return PreferedUserModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      profileImage: map['profileImage'] as String,
      preferenceOwner: map['preferenceOwner'] as String,
    );
  }
}
