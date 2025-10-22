import 'package:b2_people/src/views/strategies/home/home_rendering_strategy.dart';
import 'package:flutter/material.dart';

class LoadingRenderingStrategy implements HomeRenderingStrategy {
  @override
  Widget render(BuildContext context) {
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
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
