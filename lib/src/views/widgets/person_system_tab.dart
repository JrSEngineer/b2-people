// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/person_model.dart';
import 'package:flutter/material.dart';

class PersonSystemTab extends StatefulWidget {
  const PersonSystemTab({required this.person, super.key});

  final Person person;

  @override
  State<PersonSystemTab> createState() => _PersonSystemTabState();
}

class _PersonSystemTabState extends State<PersonSystemTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          runSpacing: 12,
          spacing: 12,
          direction: Axis.horizontal,
          children: [
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.perm_identity, color: Colors.grey.shade900),
                  Text(widget.person.login.uuid, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.date_range_rounded, color: Colors.grey.shade900),
                  Text(widget.person.registered.date.toIso8601String(), style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, color: Colors.grey.shade900),
                  Text(widget.person.identifier.name, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email, color: Colors.grey.shade900),
                  Text(widget.person.email, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
