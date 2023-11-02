import 'package:flutter/material.dart';

import '../data/resources/color_resources.dart';
import '../data/resources/constant_resources.dart';
import 'initial_loader.dart';

class IntermediateLoader extends StatelessWidget {
  const IntermediateLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        width: DEVICE_WIDTH,
        height: DEVICE_HEIGHT,
        color: WHITE_OPACITY_8,
        child: const InitialLoader(),
      ),
    );
  }
}
