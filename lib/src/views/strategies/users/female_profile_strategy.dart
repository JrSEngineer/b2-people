// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/person_model.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/users/users_controller.dart';
import 'package:b2_people/src/views/strategies/users/user_rendering_strategy.dart';
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

    final baseDateParts = person.dateOfBirthday.date.toIso8601String().split('T').first.split('-');
    final birthdate = '${baseDateParts[2]}-${baseDateParts[1]}-${baseDateParts[0]}';

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
              Column(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).width * 0.3,
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(person.profileImage), fit: BoxFit.fill),
                    ),
                  ),
                  Text(person.email, style: Theme.of(context).textTheme.bodyLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        '${usersController.profileMarks.value}',
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
                            Text(person.name.title, style: Theme.of(context).textTheme.bodyLarge),
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
                            Text('# ${person.login.username}', style: Theme.of(context).textTheme.bodyLarge),
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
                            Text(person.phone, style: Theme.of(context).textTheme.bodyLarge),
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
                            Text(person.cell, style: Theme.of(context).textTheme.bodyLarge),
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
                            Text('${person.dateOfBirthday.age}', style: Theme.of(context).textTheme.bodyLarge),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
