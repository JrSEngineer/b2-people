import 'package:b2_people/src/views/strategies/users/user_rendering_strategy.dart';
import 'package:flutter/material.dart';

class UserPageBody {
  UserProfileStrategy? _strategy;

  void setProfileStrategy(UserProfileStrategy strategy) {
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
