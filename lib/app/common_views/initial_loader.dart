import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class InitialLoader extends StatelessWidget {
  const InitialLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.hexagonDots(
      color: Colors.red,
      size: 30,
    );
  }
}
