// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/basic_person_model.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/users/users_controller.dart';
import 'package:b2_people/src/views/strategies/users/user_rendering_strategy.dart';
import 'package:flutter/material.dart';

class MaleProfileStrategy implements UserProfileStrategy {
  MaleProfileStrategy(this.user, this.authController, this.usersController);

  final BasicPersonModel user;
  final AuthController authController;
  final UsersController usersController;

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff321F5D),
                  Color(0xff5596FF),
                  Colors.blueAccent,
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              spacing: 36,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 8,
                          color: Colors.blueAccent,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage),
                          radius: MediaQuery.sizeOf(context).width * 0.2,
                        ),
                      ),
                    ),
                    Text(
                      user.fullName,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    /* Text(
                      user.profileUsername,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), */
                    Row(
                      spacing: 24,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Icon(Icons.star),
                            Text(
                              '${usersController.profileMarks.value}',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        if (!usersController.hasBeenMarked.value)
                          ElevatedButton(
                            onPressed: () {
                              final markedUser = PreferedUserModel(
                                id: user.id,
                                fullName: user.fullName,
                                email: user.email,
                                gender: user.gender,
                                profileImage: user.profileImage,
                                preferenceOwner: authController.userEmail,
                              );

                              usersController.markUserAsPrefered(markedUser);
                            },
                            child: Text(
                              'Favoritar',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  key: const Key('bottom_sheet_button'),
                  onPressed: () {},
                  child: Text(
                    'Mais Informações',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
