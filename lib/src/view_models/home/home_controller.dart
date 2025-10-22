// ignore_for_file: use_build_context_synchronously

import 'package:b2_people/src/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  List<UserModel> usersList = [];
  bool isLoading = false;

  int page = 1;
  int results = 20;

  Future<void> fetchUsers(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      page = 1;

      final dio = Dio();

      final response = await dio.get('https://randomuser.me/api/?page=$page&results=$results&seed=myusers');

      final users = response.data['results'] as List;

      for (var item in users) {
        var userMap = item as Map<String, dynamic>;
        final user = UserModel.fromMap(userMap);

        usersList.add(user);
      }

      notifyListeners();
    } on DioException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade800,
          content: Text(
            'Ops! Algum erro ocorreu durante a busca.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade800,
          content: Text(
            'Erro desconhecido.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  final scrollController = ScrollController();

  onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      page++;

      final dio = Dio();

      final response = await dio.get('https://randomuser.me/api/?page=$page&results=$results&seed=myusers');

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
