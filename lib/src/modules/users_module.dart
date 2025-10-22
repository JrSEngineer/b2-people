import 'package:b2_people/src/views/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsersModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => UserPage(user: r.args.data, key: const Key('user_page')),
    );
  }
}
