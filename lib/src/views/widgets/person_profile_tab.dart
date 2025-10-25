import 'package:b2_people/src/models/person_model.dart';
import 'package:flutter/material.dart';

class PersonProfileTab extends StatefulWidget {
  const PersonProfileTab({required this.person, required this.profileMarks, super.key});

  final PersonModel person;
  final int profileMarks;

  @override
  State<PersonProfileTab> createState() => _PersonProfileTabState();
}

class _PersonProfileTabState extends State<PersonProfileTab> {
  @override
  Widget build(BuildContext context) {
    final baseDateParts = widget.person.dateOfBirthday.date.toIso8601String().split('T').first.split('-');
    final birthdate = '${baseDateParts[2]}-${baseDateParts[1]}-${baseDateParts[0]}';

    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).width * 0.3,
          width: MediaQuery.sizeOf(context).width * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(widget.person.profileImage), fit: BoxFit.fill),
          ),
        ),
        Text(widget.person.email, style: Theme.of(context).textTheme.bodyLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text(
              '${widget.profileMarks}',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
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
                  Icon(Icons.person_search_outlined, color: Colors.grey.shade900),
                  Text(widget.person.name.title, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.link, color: Colors.grey.shade900),
                  Text('# ${widget.person.login.username}', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone, color: Colors.grey.shade900),
                  Text(widget.person.phone, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_android, color: Colors.grey.shade900),
                  Text(widget.person.cell, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cake_outlined, color: Colors.grey.shade900),
                  Text('${widget.person.dateOfBirthday.age}', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cake_outlined, color: Colors.grey.shade900),
                  Text(birthdate, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
