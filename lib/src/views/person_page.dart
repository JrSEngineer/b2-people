// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/person_gender.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/persons/persons_controller.dart';
import 'package:b2_people/src/views/strategies/persons/female_profile_strategy.dart';
import 'package:b2_people/src/views/strategies/persons/male_profile_strategy.dart';
import 'package:b2_people/src/views/strategies/persons/person_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final _authController = Modular.get<AuthController>();
  final _personsController = Modular.get<PersonsController>();
  String personId = '';

  Widget _body() {
    final userPageBody = PersonPageBody();

    switch (_personsController.person.value.gender) {
      case PersonGender.female:
        userPageBody.setProfileStrategy(FemaleProfileStrategy(_personsController.person.value, _authController, _personsController));
        return userPageBody.renderFemaleProfile(context);
      case PersonGender.male:
        userPageBody.setProfileStrategy(MaleProfileStrategy(_personsController.person.value, _authController, _personsController));
        return userPageBody.renderMaleProfile(context);
    }
  }

  @override
  void initState() {
    super.initState();

    _personsController.error.addListener(_errorMessageListenable);
    _personsController.success.addListener(_profileMarkListenable);

    _personsController.person.addListener(() async {
      personId = _personsController.person.value.id;

      await _personsController.getUserMarks(personId);
      await _personsController.verifyUserMark(personId, _authController.userEmail);
    });

    final usedSeed = Modular.args.params['seed'];

    _personsController.fetchPerson(usedSeed);
  }

  _errorMessageListenable() {
    if (_personsController.error.value.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red.shade800,
          content: Text(
            _personsController.error.value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }

  _profileMarkListenable() async {
    if (_personsController.success.value.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green.shade900,
          content: Text(
            _personsController.success.value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );

      await _personsController.getUserMarks(personId);
      await _personsController.verifyUserMark(personId, _authController.userEmail);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: Listenable.merge(
      [
        _personsController,
        _personsController.hasBeenMarked,
      ],
    ),
    builder: (_, __) {
      return _body();
    },
  );
}
