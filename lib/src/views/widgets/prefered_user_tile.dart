import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:b2_people/src/models/user_model.dart';
import 'package:flutter/material.dart';

class PreferedUserTile extends StatelessWidget {
  const PreferedUserTile({
    required this.user,
    this.onTap,
    super.key,
  });

  final PreferedUserModel user;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = switch (user.gender) {
      UserGender.female => Colors.pinkAccent,
      UserGender.male => Colors.blueAccent,
    };

    return ListTile(
      shape: Border(left: BorderSide(color: iconColor, width: 4)),
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              user.profileImage,
            ),
          ),
        ),
      ),
      title: Text(
        user.fullName,
      ),
      subtitle: Text(
        user.email,
      ),
      trailing: IconButton(
        onPressed: onTap,
        icon: Icon(
          Icons.delete,
        ),
      ),
    );
  }
}
