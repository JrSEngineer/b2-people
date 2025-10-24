import 'package:b2_people/src/data/interfaces/iauth_repository.dart';
import 'package:b2_people/src/data/repositories/auth_repository.dart';
import 'package:b2_people/src/modules/common_module.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/views/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [
    CommonModule(),
  ];

  @override
  void binds(Injector i) {
    i.addSingleton<GoogleSignIn>(() => GoogleSignIn.instance);
    i.addSingleton<IAuthRepository>(AuthRepository.new);
    i.addSingleton<AuthController>(AuthController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => AuthPage(key: const Key('auth_page')));
  }
}
