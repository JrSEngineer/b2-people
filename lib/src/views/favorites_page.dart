import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/home/home_controller.dart';
import 'package:b2_people/src/view_models/persons/persons_controller.dart';
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
  final _personsController = Modular.get<PersonsController>();
  final _homeController = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    _personsController.success.addListener(_profileMarkListenable);

    final accountEmail = _authController.userEmail;
    _personsController.getPreferedPersons(accountEmail);
  }

  _profileMarkListenable() {
    if (_personsController.success.value.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade900,
          content: Text(
            _personsController.success.value,
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
        animation: _personsController,
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
                if (_personsController.preferedPersonsList.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      key: const Key('user_list'),
                      shrinkWrap: true,

                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12);
                      },
                      itemCount: _personsController.preferedPersonsList.length,
                      itemBuilder: (_, i) {
                        final person = _personsController.preferedPersonsList[i];

                        return PreferedPersonTile(
                          person: person,
                          trailingWidget: IconButton(
                            onPressed: () {
                              showAppDialog(
                                context,
                                'Remover da Lista',
                                'Deseja realmente remover o perfil atual da lista de favoritos?',
                                [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await _personsController.removePreference(_authController.userEmail, person);

                                      await _homeController.refreshUsersList();
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
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                          onTap: () {
                            Modular.to.pushNamed('../persons/${person.usedSeed}');
                          },
                          key: const Key('prefered_user_tile'),
                        );
                      },
                    ),
                  ),
                if (_personsController.preferedPersonsList.isEmpty)
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
    _personsController.success.removeListener(_profileMarkListenable);

    super.dispose();
  }
}


/* 

onTap: () {
                            showAppDialog(
                              context,
                              'Remover da Lista',
                              'Deseja realmente remover o perfil atual da lista de favoritos?',
                              [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await _personsController.removePreference(_authController.userEmail, user);
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

*/