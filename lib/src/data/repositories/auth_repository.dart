import 'package:b2_people/src/data/interfaces/iauth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository(this._googleSignIn, this._firebase);

  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firebase;

  String _emailSession = '';
  String get emailSession => _emailSession;

  @override
  Future<(String?, String?)> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      final response = await _googleSignIn.authenticate();

      if (response.authentication.idToken == null) {
        return (null, 'Nenhuma conta informada.');
      }

      await _firebase.collection('users').doc(response.email).set({'online': true});
      _emailSession = response.email;

      return (response.email, null);
    } catch (e) {
      return (null, 'Erro ao realizar login.');
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebase.collection('users').doc(_emailSession).set({'online': false});
    _emailSession = '';
  }
}
