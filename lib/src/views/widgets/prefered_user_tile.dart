import 'package:b2_people/src/models/person_gender.dart';
import 'package:b2_people/src/models/person_model.dart';
import 'package:flutter/material.dart';

class PreferedPersonTile extends StatelessWidget {
  const PreferedPersonTile({
    required this.person,
    this.onTap,
    this.trailingWidget,
    super.key,
  });

  final PersonModel person;
  final Function()? onTap;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final genderColor = switch (person.gender) {
      PersonGender.female => Colors.pinkAccent,
      PersonGender.male => Colors.blueAccent,
    };

    return ListTile(
      contentPadding: EdgeInsets.only(left: 12),
      onTap: onTap,
      leading: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: genderColor),
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              person.profileImage,
            ),
          ),
        ),
      ),
      title: Text(
        '${person.name.first} ${person.name.last}',
      ),
      subtitle: Text(
        person.email,
      ),
      trailing: trailingWidget,
    );
  }
}
