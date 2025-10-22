// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/user_model.dart';
import 'package:b2_people/src/views/strategies/users/female_profile_strategy.dart';
import 'package:b2_people/src/views/strategies/users/male_profile_strategy.dart';
import 'package:b2_people/src/views/strategies/users/user_page_body.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Widget _body() {
    final userPageBody = UserPageBody();

    switch (widget.user.gender) {
      case UserGender.female:
        userPageBody.setProfileStrategy(FemaleProfileStrategy(widget.user));
        return userPageBody.renderFemaleProfile(context);
      case UserGender.male:
        userPageBody.setProfileStrategy(MaleProfileStrategy(widget.user));
        return userPageBody.renderMaleProfile(context);
    }
  }

  @override
  Widget build(BuildContext context) => _body();
}
