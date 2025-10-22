import 'package:b2_people/src/models/user_model.dart';
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
    final icon = switch (user.gender) {
      UserGender.female => Icons.woman,
      UserGender.male => Icons.man,
    };

    final iconColor = switch (user.gender) {
      UserGender.female => Colors.pinkAccent,
      UserGender.male => Colors.blueAccent,
    };

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
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
      trailing: Icon(
        icon,
        color: iconColor,
      ),
      onTap: onTap,
    );
  }
}
