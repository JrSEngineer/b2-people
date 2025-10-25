import 'package:b2_people/src/modules/common_module.dart';
import 'package:b2_people/src/views/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [
    CommonModule(),
  ];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => AuthPage(key: const Key('auth_page')));
  }
}
