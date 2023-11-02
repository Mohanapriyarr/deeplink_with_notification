import 'package:flutter/material.dart';

import '../data/resources/color_resources.dart';
import '../data/resources/constant_resources.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Color color;
  final TextStyle? style;
  final String? assetPath;
  final Color textColor;
  final Color? borderColor;
  final bool? needBorderColor;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const CommonButton({
    super.key,
    required this.title,
    this.assetPath,
    this.borderColor,
    this.onTap,
    this.textColor = WHITE,
    this.color = APP_MAIN_RED,
    this.needBorderColor = false,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: DEVICE_WIDTH,
          padding: PAD_12,
          decoration: BoxDecoration(
              border: needBorderColor! ? Border.all(color: borderColor!) : null,
              borderRadius: BorderRadius.circular(8.0),
              color: color),
          child: Center(
            child: Text(
              title,
              style: style ?? h4_dark(context)?.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
