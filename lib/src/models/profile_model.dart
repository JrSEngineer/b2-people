class ProfileModel {
  final String profileImage;
  final String email;
  final String phone;
  final String cell;
  final String profileUsername;

  ProfileModel({
    required this.profileImage,
    required this.email,
    required this.phone,
    required this.cell,
    required this.profileUsername,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      profileImage: map['picture']['large'],
      email: map['email'],
      phone: map['phone'],
      cell: map['cell'],
      profileUsername: map['login']['username'],
    );
  }
}
