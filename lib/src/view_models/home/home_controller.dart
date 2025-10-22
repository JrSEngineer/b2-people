// ignore_for_file: use_build_context_synchronously

import 'package:b2_people/src/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._dio);

  final Dio _dio;

  List<UserModel> usersList = [];
  bool isLoading = false;

  int page = 1;
  int results = 20;

  ValueNotifier<String> error = ValueNotifier('');

  Future<void> fetchUsers() async {
    try {
      isLoading = true;
      notifyListeners();

      page = 1;

      final response = await _dio.get('https://randomuser.me/api/?page=$page&results=$results&seed=myusers');

      final users = response.data['results'] as List;

      for (var item in users) {
        var userMap = item as Map<String, dynamic>;
        final user = UserModel.fromMap(userMap);

        usersList.add(user);
      }

      notifyListeners();
    } on DioException catch (_) {
      error.value = 'Ops! Algum erro ocorreu durante a busca.';
    } catch (_) {
      error.value = 'Um erro inesperado ocorreu.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  final scrollController = ScrollController();

  onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      page++;

      final response = await _dio.get('https://randomuser.me/api/?page=$page&results=$results&seed=myusers');

      final users = response.data['results'] as List;

      for (var item in users) {
        var userMap = item as Map<String, dynamic>;
        final user = UserModel.fromMap(userMap);

        usersList.add(user);
      }

      notifyListeners();
    }
  }
}
