// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/user_model.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/users/users_controller.dart';
import 'package:b2_people/src/views/strategies/users/female_profile_strategy.dart';
import 'package:b2_people/src/views/strategies/users/male_profile_strategy.dart';
import 'package:b2_people/src/views/strategies/users/user_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
  final _authController = Modular.get<AuthController>();
  final _usersController = Modular.get<UsersController>();

  Widget _body() {
    final userPageBody = UserPageBody();

    switch (widget.user.gender) {
      case UserGender.female:
        userPageBody.setProfileStrategy(FemaleProfileStrategy(widget.user, _authController, _usersController));
        return userPageBody.renderFemaleProfile(context);
      case UserGender.male:
        userPageBody.setProfileStrategy(MaleProfileStrategy(widget.user, _authController, _usersController));
        return userPageBody.renderMaleProfile(context);
    }
  }

  @override
  void initState() {
    super.initState();

    _usersController.error.addListener(_errorMessageListenable);
    _usersController.success.addListener(_profileMarkListenable);
    _usersController.profileMarks.addListener(() {
      setState(() {});
    });

    _usersController.getUserMarks(widget.user.id);
    _usersController.verifyUserMark(widget.user.id, _authController.userEmail);
  }

  _errorMessageListenable() {
    if (_usersController.error.value.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade800,
          content: Text(
            _usersController.error.value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }

  _profileMarkListenable() {
    if (_usersController.success.value.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade900,
          content: Text(
            _usersController.success.value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
      Modular.to.pop();
    }
  }

  @override
  Widget build(BuildContext context) => _body();
}
