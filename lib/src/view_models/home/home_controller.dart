// ignore_for_file: use_build_context_synchronously

import 'package:b2_people/src/data/interfaces/ihome_repository.dart';
import 'package:b2_people/src/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._repository);

  final IHomeRepository _repository;

  List<UserModel> usersList = [];
  bool isLoading = false;

  int page = 1;
  int results = 20;

  final scrollController = ScrollController();
  ValueNotifier<String> error = ValueNotifier('');

  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();

    final (users, errorMessage) = await _repository.getUsers('myusers', page, results);

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

  onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      page++;

      final (users, errorMessage) = await _repository.getUsers('myusers', page, results);

      if (errorMessage != null) {
        error.value = errorMessage;
        isLoading = false;
        notifyListeners();
        return;
      }

      usersList.addAll(users!);

      notifyListeners();
    }
  }
}
