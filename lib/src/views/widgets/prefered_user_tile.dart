import 'package:b2_people/src/models/person_gender.dart';
import 'package:b2_people/src/models/person_model.dart';
import 'package:flutter/material.dart';

class PreferedUserTile extends StatelessWidget {
  const PreferedUserTile({
    required this.user,
    this.onTap,
    super.key,
  });

  final PersonModel user;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final genderColor = switch (user.gender) {
      PersonGender.female => Colors.pinkAccent,
      PersonGender.male => Colors.blueAccent,
    };

    return ListTile(
      contentPadding: EdgeInsets.only(left: 12),
      leading: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: genderColor),
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
        '${user.name.first} ${user.name.last}',
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
