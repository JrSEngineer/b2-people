import 'package:b2_people/src/data/interfaces/iauth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository(this._googleSignIn, this._firebase);

  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firebase;

  @override
  Future<String?> signInWithGoogle() async {
    await _googleSignIn.initialize(serverClientId: 'project-224229507477');
    final response = await _googleSignIn.authenticate();

    if (response.authentication.idToken == null) {
      return 'Nenhuma conta informada.';
    }

    await _firebase.collection('users').doc(response.email).set({'online': true});

    return null;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
