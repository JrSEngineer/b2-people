import 'package:b2_people/src/view_models/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _authController = Modular.get<AuthController>();

  @override
  void initState() {
    super.initState();

    _authController.error.addListener(_authErrorListenable);
    _authController.isOnline.addListener(_authenticationListenable);
  }

  void _authErrorListenable() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade800,
        content: Text(
          _authController.error.value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  void _authenticationListenable() {
    if (_authController.isOnline.value) {
      Modular.to.navigate('/home/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Color(0xffCFBAFF),
                    Color(0xff5109F9),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                spacing: 24,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá,\nBoas vindas!',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    'Entre com sua conta do Google',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Spacer(),
                  ElevatedButton(
                    key: const Key('auth_button'),
                    onPressed: _authController.signInWithGoogle,
                    child: Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'G',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Entrar com Google',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authController.error.removeListener(_authErrorListenable);
    _authController.isOnline.removeListener(_authenticationListenable);

    super.dispose();
  }
}
