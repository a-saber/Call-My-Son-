import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField({
    super.key,
    this.enabled = true,
    this.readOnly = false,
    required this.controller,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.onChange,
    this.onTap,
    this.validator,
    this.maxLines = 1,
    this.labelText,
    this.suffixPadding = 5.0,
    this.isFillWhite=false,
    this.hintText,
  });

  final int maxLines;
  final double suffixPadding;
  final bool enabled;
  final bool readOnly;
  final bool? isPassword;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool? isFillWhite;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ??
              (value) {
        if (value!.isEmpty) {
          return 'Must not be empty';
        }
        return null;
      },
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: textInputType,
      controller: controller,
      onChanged: onChange,
      maxLines: maxLines,
      style: StyleManager.textStyle20.copyWith(
        fontWeight: FontWeight.normal,
        color: ColorsManager.black
      ),
      obscureText: isPassword!,
      obscuringCharacter: '●',
      cursorColor: ColorsManager.primary,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: StyleManager.textStyle15,
        hintStyle: StyleManager.textStyle15.copyWith(
          color: ColorsManager.borderColor
        ),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.only(end:suffixPadding),
          child: suffixIcon,
        ),
          errorStyle: StyleManager.textStyle15.copyWith(color: ColorsManager.red),
          filled: true,
          fillColor:ColorsManager.white,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.borderLineColor),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.primary),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color:  ColorsManager.red,
              )
          ),
          errorBorder:  UnderlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color:  ColorsManager.red,
              )
          ),
      ),
    );
  }
}

