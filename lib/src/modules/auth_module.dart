import 'package:b2_people/src/data/interfaces/iauth_repository.dart';
import 'package:b2_people/src/data/repositories/auth_repository.dart';
import 'package:b2_people/src/views/auth_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<GoogleSignIn>(() => GoogleSignIn.instance);
    i.addSingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    i.addSingleton<IAuthRepository>(AuthRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => AuthPage());
  }
}
