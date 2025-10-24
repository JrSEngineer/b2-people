abstract interface class IAuthRepository {
  Future<String?> signInWithGoogle();
  Future<void> signOut();
}
