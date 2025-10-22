// ignore_for_file: use_build_context_synchronously

import 'package:b2_people/src/view_models/home/home_controller.dart';
import 'package:b2_people/src/views/strategies/home/body_rendering_strategy.dart';
import 'package:b2_people/src/views/strategies/home/home_body.dart';
import 'package:b2_people/src/views/strategies/home/loading_rendering_strategy.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _dio = Dio();
  late final _homeController = HomeController(_dio);

  @override
  void initState() {
    super.initState();

    _homeController.fetchUsers();
    _homeController.scrollController.addListener(_homeController.onScroll);
    _homeController.error.addListener(_usersFetchingErrorListenable);
  }

  Widget _body() {
    HomeBody body = HomeBody();

    return AnimatedBuilder(
      animation: _homeController,
      builder: (_, __) {
        if (_homeController.isLoading) {
          body.setRenderingStrategy(LoadingRenderingStrategy());
          return body.renderLoading(context);
        } else {
          body.setRenderingStrategy(BodyRenderingStrategy(_homeController));
          return body.renderUsersList(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => _body();

  _usersFetchingErrorListenable() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade800,
        content: Text(
          _homeController.error.value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _homeController.scrollController.removeListener(_homeController.onScroll);
    _homeController.error.removeListener(_usersFetchingErrorListenable);
    super.dispose();
  }
}
