import 'package:b2_people/src/data/interfaces/iusers_repository.dart';
import 'package:b2_people/src/data/repositories/users_repository.dart';
import 'package:b2_people/src/modules/common_module.dart';
import 'package:b2_people/src/views/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsersModule extends Module {
  @override
  List<Module> get imports => [
    CommonModule(),
  ];

  @override
  void binds(Injector i) {
    i.addSingleton<IUsersRepository>(UsersRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => UserPage(user: r.args.data, key: const Key('user_page')),
    );
  }
}
