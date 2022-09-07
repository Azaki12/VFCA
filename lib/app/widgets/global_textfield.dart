import 'package:flutter/material.dart';
import '../core/utils/extensions.dart';

class GlobalTextField extends StatelessWidget {
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obsecure;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? filled;
  final Color? suffixColor;
  final int maxLines;
  const GlobalTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.onSuffixTap,
    this.suffixIcon,
    this.maxLines = 1,
    this.obsecure = false,
    this.inputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onSaved,
    this.validator,
    this.controller,
    this.filled = true,
    this.suffixColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecure,
      keyboardType: inputType,
      textInputAction: textInputAction,
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLines,
      decoration: CustomInputDecoration.decorate(
        hintText: hintText,
        prefixIcon: prefixIcon,
        onSuffixTap: onSuffixTap,
        suffixIcon: suffixIcon,
        suffixColor: suffixColor,
        filled: filled,
      ),
    );
  }
}
