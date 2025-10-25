import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/users/users_controller.dart';
import 'package:b2_people/src/views/overlays/app_dialog.dart';
import 'package:b2_people/src/views/widgets/prefered_user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _authController = Modular.get<AuthController>();
  final _usersController = Modular.get<UsersController>();

  @override
  void initState() {
    super.initState();
    _usersController.success.addListener(_profileMarkListenable);

    final accountEmail = _authController.userEmail;
    _usersController.getPreferedUsers(accountEmail);
  }

  _profileMarkListenable() {
    if (_usersController.success.value.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade900,
          content: Text(
            _usersController.success.value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
      Modular.to.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5109F9),
        title: Text(
          'Favoritos',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _usersController,
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
                Text(
                  'Usuários',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (_usersController.preferedUsersList.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      key: const Key('user_list'),
                      shrinkWrap: true,

                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8);
                      },
                      itemCount: _usersController.preferedUsersList.length,
                      itemBuilder: (_, i) {
                        final user = _usersController.preferedUsersList[i];

                        return PreferedUserTile(
                          user: user,
                          onTap: () {
                            showAppDialog(
                              context,
                              'Remover da Lista',
                              'Deseja realmente remover o perfil atual da lista de favoritos?',
                              [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await _usersController.removePreference(user);
                                  },
                                  child: Text('SIM', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('NÃO'),
                                ),
                              ],
                            );
                          },
                          key: const Key('prefered_user_tile'),
                        );
                      },
                    ),
                  ),
                if (_usersController.preferedUsersList.isEmpty)
                  Center(
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
    _usersController.success.removeListener(_profileMarkListenable);

    super.dispose();
  }
}
