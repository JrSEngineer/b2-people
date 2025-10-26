import 'package:b2_people/src/data/interfaces/ipersons_repository.dart';
import 'package:b2_people/src/models/person_model.dart';
import 'package:flutter/material.dart';

class PersonsController extends ChangeNotifier {
  PersonsController(this._repository);

  final IPersonsRepository _repository;

  List<PersonModel> preferedPersonsList = [];
  ValueNotifier<int> profileMarks = ValueNotifier(0);
  bool isLoading = false;
  ValueNotifier<bool> hasBeenMarked = ValueNotifier(false);

  ValueNotifier<PersonModel> person = ValueNotifier(PersonModel.empty());

  ValueNotifier<String> success = ValueNotifier('');
  ValueNotifier<String> error = ValueNotifier('');

  Future<void> fetchPerson(String seed) async {
    await Future.delayed(const Duration(milliseconds: 10));

    isLoading = true;
    notifyListeners();

    final (personResponse, errorMessage) = await _repository.fetchPerson(seed);
    if (errorMessage != null) {
      error.value = errorMessage;
      isLoading = false;
      notifyListeners();

      return;
    }

    person.value = personResponse!;

    isLoading = false;
    notifyListeners();
  }

  Future<void> markPersonAsPrefered(String accountEmail, PersonModel person) async {
    isLoading = true;
    notifyListeners();

    final hasBeenMarkedAsPrefered = await _repository.markPersonAsPrefered(accountEmail, person);

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

  Future<void> removePreference(String accountEmail, PersonModel person) async {
    isLoading = true;
    notifyListeners();

    final hasPreferenceRemoved = await _repository.removePreference(accountEmail, person);

    if (hasPreferenceRemoved) {
      success.value = 'Preferência de perfil removida.';

      isLoading = false;
      notifyListeners();
      return;
    }

    preferedPersonsList.remove(person);

    error.value = 'Erro ao remover preferência.';

    isLoading = false;
    notifyListeners();
  }

  Future<void> verifyUserMark(String userId, String accountEmail) async {
    final result = await _repository.verifyPersonMark(userId, accountEmail);
    hasBeenMarked.value = result;
  }

  Future<void> getPreferedPersons(String accountEmail) async {
    isLoading = true;
    notifyListeners();

    preferedPersonsList.clear();

    final (preferedUsers, errorMessage) = await _repository.getPreferedPersons(accountEmail);

    if (errorMessage != null) {
      error.value = errorMessage;
      isLoading = false;
      notifyListeners();

      return;
    }

    preferedPersonsList.addAll(preferedUsers!);

    isLoading = false;
    notifyListeners();
  }

  Future<void> getUserMarks(String userId) async {
    isLoading = true;
    notifyListeners();
    final (profileMarksAmount, errorMessage) = await _repository.getPersonMarks(userId);

    if (errorMessage != null) {
      error.value = errorMessage;
      isLoading = false;
      notifyListeners();

      return;
    }

    profileMarks.value = profileMarksAmount!;

    isLoading = false;
    notifyListeners();
  }
}
