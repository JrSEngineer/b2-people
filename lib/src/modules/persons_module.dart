import 'package:b2_people/src/data/interfaces/ipersons_repository.dart';
import 'package:b2_people/src/data/repositories/persons_repository_impl.dart';
import 'package:b2_people/src/modules/common_module.dart';
import 'package:b2_people/src/view_models/persons/persons_controller.dart';
import 'package:b2_people/src/views/favorites_page.dart';
import 'package:b2_people/src/views/person_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PersonsModule extends Module {
  @override
  List<Module> get imports => [
    CommonModule(),
  ];

  @override
  void binds(Injector i) {
    i.addSingleton<IPersonsRepository>(PersonsRepositoryImpl.new);
    i.addSingleton<PersonsController>(PersonsController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/:seed', child: (_) => PersonPage(key: const Key('user_page')));
    r.child('/favorites', child: (_) => FavoritesPage(key: const Key('favorites_page')));
  }
}
