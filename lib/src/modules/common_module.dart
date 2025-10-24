import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CommonModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  }
}
