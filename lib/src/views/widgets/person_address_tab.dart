import 'package:b2_people/src/models/person_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class PersonAddressTab extends StatefulWidget {
  const PersonAddressTab({required this.person, super.key});

  final PersonModel person;

  @override
  State<PersonAddressTab> createState() => _PersonAddressTabState();
}

class _PersonAddressTabState extends State<PersonAddressTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 48,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CountryFlag.fromCountryCode(
          widget.person.naturallity,
          theme: ImageTheme(
            height: MediaQuery.sizeOf(context).width * 0.24,
            width: MediaQuery.sizeOf(context).width * 0.32,
            shape: RoundedRectangle(4),
          ),
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
                  Icon(Icons.flag_outlined, color: Colors.grey.shade900),
                  Text(widget.person.address.country, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.grey.shade900),
                  Text(widget.person.address.state, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_city, color: Colors.grey.shade900),
                  Text(widget.person.address.city, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: Colors.grey.shade900),
                  Text(widget.person.address.streetName, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.numbers, color: Colors.grey.shade900),
                  Text('${widget.person.address.streetNumber}', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
              label: Row(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.post_add_outlined, color: Colors.grey.shade900),
                  Text(widget.person.address.postcode, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
