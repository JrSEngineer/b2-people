import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/data/repositories/home_repository_impl.dart';
import 'package:b2_people/src/modules/common_module.dart';
import 'package:b2_people/src/modules/persons_module.dart';
import 'package:b2_people/src/view_models/home/home_controller.dart';
import 'package:b2_people/src/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
    CommonModule(),
  ];

  @override
  void binds(Injector i) {
    i.addSingleton<IHomeRepository>(HomeRepositoryImpl.new);
    i.addSingleton<HomeController>(HomeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => HomePage(key: const Key('home_page')));
    r.module('/persons/', module: PersonsModule());
  }
}
