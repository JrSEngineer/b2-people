import 'package:b2_people/src/data/interfaces/iauth_repository.dart';
import 'package:b2_people/src/data/repositories/auth_repository.dart';
import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CommonModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<GoogleSignIn>(() => GoogleSignIn.instance);
    i.addSingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    i.addSingleton<IAuthRepository>(AuthRepository.new);
    i.addSingleton<AuthController>(AuthController.new);
  }
}
