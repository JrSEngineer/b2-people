// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/person_gender.dart';
import 'package:b2_people/src/models/person_model.dart';
import 'package:flutter/material.dart';

class PersonSystemTab extends StatefulWidget {
  const PersonSystemTab({required this.person, super.key});

  final PersonModel person;

  @override
  State<PersonSystemTab> createState() => _PersonSystemTabState();
}

class _PersonSystemTabState extends State<PersonSystemTab> {
  @override
  Widget build(BuildContext context) {
    final genderColor = widget.person.gender == PersonGender.female ? Colors.pinkAccent : Colors.blueAccent;
    final registrationInfo = widget.person.registered.age > 1 ? 'Registrado há ${widget.person.registered.age} anos' : 'Registrado há ${widget.person.registered.age} ano';

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.computer,
          size: MediaQuery.sizeOf(context).height * 0.14,
          color: Colors.grey.shade900,
        ),
        Wrap(
          runSpacing: 12,
          spacing: 12,
          direction: Axis.horizontal,
          children: [
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: 'Identificador de usuário',
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  side: BorderSide(color: genderColor),
                ),
                label: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.perm_identity, color: Colors.grey.shade900),
                    Text(widget.person.login.uuid, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: 'Código SHA-1',
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  side: BorderSide(color: genderColor),
                ),
                label: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.key, color: Colors.grey.shade900),
                    Text(widget.person.login.sha1, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: 'Código SHA-256',
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  side: BorderSide(color: genderColor),
                ),
                label: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.vpn_key, color: Colors.grey.shade900),
                    Expanded(child: Text(widget.person.login.sha256, style: Theme.of(context).textTheme.bodyLarge)),
                  ],
                ),
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: 'Código MD5',
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  side: BorderSide(color: genderColor),
                ),
                label: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.folder_copy_outlined, color: Colors.grey.shade900),
                    Text(widget.person.login.md5, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: 'Timestap de registro',
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  side: BorderSide(color: genderColor),
                ),
                label: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.date_range_rounded, color: Colors.grey.shade900),
                    Text(widget.person.registered.date.toIso8601String(), style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: 'Identificador pessoal',
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  side: BorderSide(color: genderColor),
                ),
                label: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, color: Colors.grey.shade900),
                    Text(widget.person.identifier.name, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: 'Senha no sistema',
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  side: BorderSide(color: genderColor),
                ),
                label: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.password, color: Colors.grey.shade900),
                    Text(widget.person.login.password, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: 'Código Salt',
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  side: BorderSide(color: genderColor),
                ),
                label: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.pattern, color: Colors.grey.shade900),
                    Text(widget.person.login.salt, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        Text(registrationInfo, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
