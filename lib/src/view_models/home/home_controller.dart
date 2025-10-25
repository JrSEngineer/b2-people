// ignore_for_file: use_build_context_synchronously

import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/models/basic_person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:uuid/uuid.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._repository);

  final IHomeRepository _repository;

  List<BasicPersonModel> usersList = [];
  bool isLoading = false;

  int page = 1;
  int results = 1;

  final scrollController = ScrollController();
  ValueNotifier<String> error = ValueNotifier('');

  late final ValueNotifier<Ticker> ticker = ValueNotifier(
    Ticker(
      (ticks) async {
        final tickValueInSeconds = ticks.inSeconds;

        if (tickValueInSeconds == 5) {
          ticker.value.stop();
          await fetchUsers();
          ticker.value.start();
        }
      },
    ),
  );

  void startProgressiveFetching() async {
    await fetchUsers();
    ticker.value.start();
  }

  void stopProgressiveFetching() {
    ticker.value.stop();
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();

    if (usersList.isEmpty) {
      final (savedPerson, _) = await _repository.getSavedPersons();

      if (savedPerson != null) {
        usersList.addAll(savedPerson);
      }
      isLoading = false;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 5));
    }

    final seed = Uuid().v4();

    final (users, errorMessage) = await _repository.getPersons(seed, page, results);

    if (errorMessage != null) {
      error.value = errorMessage;
      isLoading = false;
      notifyListeners();
      return;
    }

    usersList.addAll(users!);

    isLoading = false;
    notifyListeners();
  }
}
