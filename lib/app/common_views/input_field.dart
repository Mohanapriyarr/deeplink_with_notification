import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/resources/color_resources.dart';
import '../data/resources/constant_resources.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Icon? prefixIcon;
  final Widget? prefixWidget;
  final Icon? suffixIcon;
  final Widget? suffixWidget;
  final Function()? suffixIconTap;
  final TextStyle? hintStyle;
  final String hintText;
  final bool expands;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final bool needBorder;
  final bool autoFocus;
  final TextCapitalization textCapital;
  final bool isNotEnabled;
  final Color? fillColor;

  const InputField({
    super.key,
    required this.textEditingController,
    this.keyboardType = TextInputType.name,
    required this.focusNode,
    this.textStyle,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.suffixIconTap,
    this.hintStyle,
    required this.hintText,
    this.expands = false,
    this.minLines,
    this.textInputAction,
    this.textAlign,
    this.needBorder = false,
    this.autoFocus = false,
    this.textCapital = NONE,
    this.isNotEnabled = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: DARK_BLUE_WITH_OPACITY,
              ),
        ),
        child: TextFormField(
          expands: expands,
          enabled: isNotEnabled ? false : true,
          autofocus: autoFocus,
          controller: textEditingController,
          keyboardType: keyboardType,
          focusNode: focusNode,
          style: textStyle ??
              h4_light(context)?.copyWith(color: DARK_BLUE, fontSize: 14),
          readOnly: readOnly,
          textCapitalization: textCapital,
          obscureText: obscureText,
          maxLines: expands ? null : maxLines,
          minLines: expands ? null : minLines,
          cursorColor: DARK_BLUE_WITH_OPACITY,
          textInputAction: textInputAction ?? TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlign: textAlign ?? TextAlign.start,
          onChanged: (value) => print('Print value $value'),
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            errorMaxLines: 5,
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 0.5, color: APP_LIGHT_GREY_INPUT_FIELD)),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 0.5, color: DARK_BLUE_WITH_OPACITY)),
            errorBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 0.5, color: DARK_BLUE_WITH_OPACITY)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 0.5, color: DARK_BLUE_WITH_OPACITY)),
            fillColor: fillColor,
            filled: fillColor == null ? false : true,
            labelStyle: const TextStyle(color: TEXT_HEADING, fontSize: 20),
            prefixIcon: prefixWidget ?? prefixIcon,
            prefixIconColor: DARK_BLUE,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: suffixIconTap,
                    child: suffixIcon,
                  )
                : suffixWidget,
            suffixIconColor: ICON_GREY,
            hintStyle: hintStyle ??
                h4_dark(context)?.copyWith(color: ICON_GREY, fontSize: 13),
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          ),
        ),
      ),
    );
  }
}
