import 'package:b2_people/src/modules/home_module.dart';
import 'package:b2_people/src/modules/users_module.dart';
import 'package:b2_people/src/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => SplashPage(key: const Key('splash_page')),
    );
    r.module('/home/', module: HomeModule());
    r.module('/users/', module: UsersModule());
  }
}
