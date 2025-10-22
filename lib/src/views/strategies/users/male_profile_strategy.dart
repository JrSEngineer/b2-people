import 'package:b2_people/src/models/user_model.dart';
import 'package:b2_people/src/views/overlays/user_info_bottom_sheet.dart';
import 'package:b2_people/src/views/strategies/users/user_rendering_strategy.dart';
import 'package:flutter/material.dart';

class MaleProfileStrategy implements UserProfileStrategy {
  MaleProfileStrategy(this.user);

  final UserModel user;

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
                      backgroundImage: NetworkImage(user.profile.profileImage),
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
                  user.profile.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.profile.phone,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.profile.profileUsername,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  key: const Key('bottom_sheet_button'),
                  onPressed: () => userInfoBottomSheet(context, user),
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
