import 'package:b2_people/src/views/strategies/persons/person_rendering_strategy.dart';
import 'package:flutter/material.dart';

class PersonPageBody {
  PersonProfileStrategy? _strategy;

  void setProfileStrategy(PersonProfileStrategy strategy) {
    _strategy = strategy;
  }

  Widget renderMaleProfile(BuildContext context) {
    if (_strategy == null) {
      return Container();
    }
    return _strategy!.render(context);
  }

  Widget renderFemaleProfile(BuildContext context) {
    if (_strategy == null) {
      return Container();
    }
    return _strategy!.render(context);
  }
}
