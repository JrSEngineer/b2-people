import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff5109F9),
      child: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).width * 0.4,
          width: MediaQuery.sizeOf(context).width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/icons/b2people_icon.png'),
            ),
          ),
        ),
      ),
    );
  }
}
