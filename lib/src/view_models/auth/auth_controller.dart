import 'package:b2_people/src/data/interfaces/iauth_repository.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._repository);

  final IAuthRepository _repository;

  bool isLoading = false;
  ValueNotifier<String> error = ValueNotifier('');
  ValueNotifier<bool> isOnline = ValueNotifier(false);

  Future<void> signInWithGoogle() async {
    isLoading = true;
    notifyListeners();

    final result = await _repository.signInWithGoogle();

    if (result != null) {
      isLoading = false;

      error.value = result;
      notifyListeners();
      return;
    }

    isOnline.value = true;

    isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _repository.signOut();
    isOnline.value = false;
  }
}
