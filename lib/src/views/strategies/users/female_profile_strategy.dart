// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/person_model.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/users/users_controller.dart';
import 'package:b2_people/src/views/strategies/users/user_rendering_strategy.dart';
import 'package:b2_people/src/views/widgets/person_address_tab.dart';
import 'package:b2_people/src/views/widgets/person_profile_tab.dart';
import 'package:b2_people/src/views/widgets/person_system_tab.dart';
import 'package:flutter/material.dart';

class FemaleProfileStrategy implements UserProfileStrategy {
  FemaleProfileStrategy(this.person, this.authController, this.usersController);

  final Person person;
  final AuthController authController;
  final UsersController usersController;

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
              onPressed: () {
                final markedUser = PreferedUserModel(
                  id: person.id,
                  fullName: '${person.name.first} ${person.name.last}',
                  email: person.email,
                  gender: person.gender,
                  profileImage: person.profileImage,
                  preferenceOwner: authController.userEmail,
                );

                usersController.markUserAsPrefered(markedUser);
              },
              icon: Icon(Icons.star),
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
