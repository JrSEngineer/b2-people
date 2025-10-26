import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:b2_people/src/view_models/home/home_controller.dart';
import 'package:b2_people/src/views/overlays/app_dialog.dart';
import 'package:b2_people/src/views/strategies/home/home_rendering_strategy.dart';
import 'package:b2_people/src/views/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BodyRenderingStrategy implements HomeRenderingStrategy {
  BodyRenderingStrategy(this._authController, this._homeController);

  final AuthController _authController;
  final HomeController _homeController;

  @override
  Widget render(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        showAppDialog(
          context,
          'Sair do App',
          'Deseja realmente fechar a aplicação?',
          [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await _authController.signOut();
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
      child: Scaffold(
        appBar: AppBar(
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
              key: const Key('ticker_button'),
              onPressed: () {
                _homeController.ticker.value.isActive ? _homeController.stopProgressiveFetching() : _homeController.startProgressiveFetching();
              },
              icon: Icon(_homeController.ticker.value.isActive ? Icons.pause : Icons.play_arrow_outlined),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 24,
                children: [
                  Text(
                    'Usuários',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${_homeController.basicPersonsList.length}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  key: const Key('user_list'),
                  controller: _homeController.scrollController,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _homeController.basicPersonsList.length,
                  itemBuilder: (_, i) {
                    final user = _homeController.basicPersonsList[i];

                    return _homeController.basicPersonsList.isNotEmpty
                        ? UserTile(
                            user: user,
                            onTap: () {
                              Modular.to.pushNamed('persons/${user.usedSeed}');
                            },
                            key: const Key('user_tile'),
                          )
                        : Center(
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
                  },
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.pushNamed('persons/favorites');
          },
          child: Icon(
            Icons.storage,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
