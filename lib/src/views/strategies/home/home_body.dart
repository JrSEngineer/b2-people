import 'package:b2_people/src/views/strategies/home/home_rendering_strategy.dart';
import 'package:flutter/material.dart';

class HomeBody {
  HomeRenderingStrategy? _strategy;

  void setRenderingStrategy(HomeRenderingStrategy strategy) {
    _strategy = strategy;
  }

  Widget renderLoading(BuildContext context) {
    if (_strategy == null) {
      return Container();
    }
    return _strategy!.render(context);
  }

  Widget renderUsersList(BuildContext context) {
    if (_strategy == null) {
      return Container();
    }
    return _strategy!.render(context);
  }
}
