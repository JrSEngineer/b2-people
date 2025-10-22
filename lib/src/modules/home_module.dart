import 'package:b2_people/src/views/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => HomePage());
  }
}
