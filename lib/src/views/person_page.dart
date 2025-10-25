// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/person_gender.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/users/users_controller.dart';
import 'package:b2_people/src/views/strategies/users/female_profile_strategy.dart';
import 'package:b2_people/src/views/strategies/users/male_profile_strategy.dart';
import 'package:b2_people/src/views/strategies/users/user_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final _authController = Modular.get<AuthController>();
  final _usersController = Modular.get<UsersController>();
  String personId = '';

  Widget _body() {
    final userPageBody = UserPageBody();

    switch (_usersController.person.value.gender) {
      case PersonGender.female:
        userPageBody.setProfileStrategy(FemaleProfileStrategy(_usersController.person.value, _authController, _usersController));
        return userPageBody.renderFemaleProfile(context);
      case PersonGender.male:
        userPageBody.setProfileStrategy(MaleProfileStrategy(_usersController.person.value, _authController, _usersController));
        return userPageBody.renderMaleProfile(context);
    }
  }

  @override
  void initState() {
    super.initState();

    _usersController.error.addListener(_errorMessageListenable);
    _usersController.success.addListener(_profileMarkListenable);

    _usersController.person.addListener(() async {
      personId = _usersController.person.value.id;

      await _usersController.getUserMarks(personId);
      await _usersController.verifyUserMark(personId, _authController.userEmail);
    });

    final usedSeed = Modular.args.params['seed'];

    _usersController.fetchPerson(usedSeed);
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

  _profileMarkListenable() async {
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

      await _usersController.getUserMarks(personId);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _usersController,
    builder: (_, __) {
      return _body();
    },
  );
}
