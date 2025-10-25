import 'package:b2_people/src/data/interfaces/iusers_repository.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:flutter/material.dart';

class UsersController extends ChangeNotifier {
  UsersController(this._repository);

  final IUsersRepository _repository;

  List<PreferedUserModel> preferedUsersList = [];
  ValueNotifier<int> profileMarks = ValueNotifier(0);
  bool isLoading = false;
  ValueNotifier<bool> hasBeenMarked = ValueNotifier(false);

  ValueNotifier<String> success = ValueNotifier('');
  ValueNotifier<String> error = ValueNotifier('');

  Future<void> markUserAsPrefered(PreferedUserModel user) async {
    isLoading = true;
    notifyListeners();

    final hasBeenMarkedAsPrefered = await _repository.markUserAsPrefered(user);

    if (hasBeenMarkedAsPrefered) {
      success.value = 'Perfil de usuário marcado como favorito.';

      isLoading = false;
      notifyListeners();
      return;
    }

    error.value = 'Erro ao favoritar perfil de usuário.';

    isLoading = false;
    notifyListeners();
  }

  Future<void> removePreference(PreferedUserModel user) async {
    isLoading = true;
    notifyListeners();

    final hasPreferenceRemoved = await _repository.removePreference(user);

    if (hasPreferenceRemoved) {
      success.value = 'Preferência de perfil removida.';

      isLoading = false;
      notifyListeners();
      return;
    }

    error.value = 'Erro ao remover preferência.';

    isLoading = false;
    notifyListeners();
  }

  Future<void> verifyUserMark(String userId, String accountEmail) async {
    final result = await _repository.verifyUserMark(userId, accountEmail);
    hasBeenMarked.value = result;
  }

  Future<void> getPreferedUsers(String accountEmail) async {
    isLoading = true;
    notifyListeners();
    final (preferedUsers, errorMessage) = await _repository.getPreferedUsers(accountEmail);

    if (errorMessage != null) {
      error.value = errorMessage;
      isLoading = false;
      notifyListeners();

      return;
    }

    preferedUsersList.addAll(preferedUsers!);

    isLoading = true;
    notifyListeners();
  }

  Future<void> getUserMarks(String userId) async {
    isLoading = true;
    notifyListeners();
    final (profileMarksAmount, errorMessage) = await _repository.getUserMarks(userId);

    if (errorMessage != null) {
      error.value = errorMessage;
      isLoading = false;
      notifyListeners();

      return;
    }

    profileMarks.value = profileMarksAmount!;

    isLoading = true;
    notifyListeners();
  }
}
