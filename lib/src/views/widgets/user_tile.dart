import 'package:b2_people/src/models/user_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.user,
    this.onTap,
    super.key,
  });

  final UserModel user;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final genderColor = switch (user.gender) {
      UserGender.female => Colors.pinkAccent,
      UserGender.male => Colors.blueAccent,
    };

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: genderColor),
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              user.profile.profileImage,
            ),
          ),
        ),
      ),
      title: Text(
        user.fullName,
      ),
      subtitle: Text(
        user.profile.email,
      ),
      trailing: CountryFlag.fromCountryCode(
        user.address.naturallity,
        theme: const ImageTheme(
          height: 24,
          width: 30,
          shape: RoundedRectangle(4),
        ),
      ),
      onTap: onTap,
    );
  }
}
