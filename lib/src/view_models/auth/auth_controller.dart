import 'package:b2_people/src/data/interfaces/iauth_repository.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._repository);

  final IAuthRepository _repository;

  bool isLoading = false;
  ValueNotifier<String> error = ValueNotifier('');
  ValueNotifier<bool> isOnline = ValueNotifier(false);
  String userEmail = '';

  Future<void> signInWithGoogle() async {
    isLoading = true;
    notifyListeners();

    final (result, errorMessage) = await _repository.signInWithGoogle();

    if (errorMessage != null) {
      isLoading = false;

      error.value = errorMessage;
      notifyListeners();
      return;
    }

    isOnline.value = true;
    userEmail = result!;

    isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _repository.signOut();
    isOnline.value = false;
    userEmail = '';
  }
}
