// ignore_for_file: use_build_context_synchronously

import 'package:b2_people/src/models/user_model.dart';
import 'package:b2_people/src/view_models/home/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5109F9),
        title: Text(
          'B2 People',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _homeController.fetchUsers,
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _homeController,
        builder: (_, __) {
          return Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_homeController.usersList.isNotEmpty)
                  Text(
                    'Usuários',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                if (!_homeController.isLoading)
                  Expanded(
                    child: ListView.builder(
                      controller: _homeController.scrollController,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _homeController.usersList.length + 1,
                      itemBuilder: (_, i) {
                        if (i < _homeController.usersList.length) {
                          final user = _homeController.usersList[i];

                          final icon = switch (user.gender) {
                            UserGender.female => Icons.woman,
                            UserGender.male => Icons.man,
                          };

                          final iconColor = switch (user.gender) {
                            UserGender.female => Colors.pinkAccent,
                            UserGender.male => Colors.blueAccent,
                          };

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    user.profile.profileImage,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              user.fullName,
                            ),
                            subtitle: Text(
                              user.profile.email,
                            ),
                            trailing: Icon(
                              icon,
                              color: iconColor,
                            ),
                            onTap: () {
                              Modular.to.pushNamed('../users/', arguments: user);
                            },
                          );
                        } else {
                          if (_homeController.usersList.isEmpty) {
                            return Center(
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.sizeOf(context).width * 0.6,
                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          'assets/images/no-users-image.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Sem Usuários no momento...',
                                  ),
                                ],
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                if (_homeController.isLoading)
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).width * 0.6,
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                'assets/images/no-users-image.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Sem Usuários no momento...',
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
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
