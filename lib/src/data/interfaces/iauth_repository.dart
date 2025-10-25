abstract interface class IAuthRepository {
  Future<(String?, String?)> signInWithGoogle();
  Future<void> signOut();
}
