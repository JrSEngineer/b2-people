import 'package:b2_people/src/modules/auth_module.dart';
import 'package:b2_people/src/modules/home_module.dart';
import 'package:b2_people/src/modules/persons_module.dart';
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
    r.module('/auth/', module: AuthModule());
    r.module('/home/', module: HomeModule());
    r.module('/persons/', module: PersonsModule());
  }
}
