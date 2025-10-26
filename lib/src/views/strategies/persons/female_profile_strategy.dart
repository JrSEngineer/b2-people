// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/person_model.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/persons/persons_controller.dart';
import 'package:b2_people/src/views/strategies/persons/person_rendering_strategy.dart';
import 'package:b2_people/src/views/widgets/person_address_tab.dart';
import 'package:b2_people/src/views/widgets/person_profile_tab.dart';
import 'package:b2_people/src/views/widgets/person_system_tab.dart';
import 'package:flutter/material.dart';

class FemaleProfileStrategy implements PersonProfileStrategy {
  FemaleProfileStrategy(this.person, this.authController, this.usersController);

  final PersonModel person;
  final AuthController authController;
  final PersonsController usersController;

  @override
  Widget render(BuildContext context) {
    final personInfoSections = [
      Column(
        spacing: 4,
        children: [
          Icon(Icons.person_outline),
          Text('Perfil'),
        ],
      ),
      Column(
        spacing: 4,
        children: [
          Icon(Icons.house),
          Text('Endereço'),
        ],
      ),
      Column(
        spacing: 4,
        children: [
          Icon(Icons.computer),
          Text('Sistema'),
        ],
      ),
    ];

    final displayIcon = usersController.hasBeenMarked.value ? Icons.star : Icons.star_border;

    return DefaultTabController(
      length: personInfoSections.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${person.name.first} ${person.name.last}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorAnimation: TabIndicatorAnimation.elastic,
            indicatorWeight: 4,
            padding: EdgeInsets.all(8),
            dividerColor: Colors.transparent,
            tabs: personInfoSections,
          ),
          actions: [
            IconButton(
              onPressed: usersController.hasBeenMarked.value
                  ? () async {
                      await usersController.removePreference(authController.userEmail, person);
                    }
                  : () async {
                      await usersController.markPersonAsPrefered(authController.userEmail, person);
                    },
              icon: Icon(displayIcon),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: TabBarView(
            children: [
              PersonProfileTab(person: person, profileMarks: usersController.profileMarks.value),
              PersonAddressTab(person: person),
              PersonSystemTab(person: person),
            ],
          ),
        ),
      ),
    );
  }
}
