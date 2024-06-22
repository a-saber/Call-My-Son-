import 'package:call_son/core/core_widgets/default_button/remove_button.dart';
import 'package:call_son/core/core_widgets/default_form/default_form_field2.dart';
import 'package:flutter/material.dart';

class DefaultAddItemRow extends StatelessWidget {
  const DefaultAddItemRow(
      {super.key,
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
        this.suffixPadding = 5.0,
        this.isFillWhite=false,
        this.hintText,
      required this.onTapButton,
      });

  final int maxLines;
  final double suffixPadding;
  final bool enabled;
  final bool readOnly;
  final bool? isPassword;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool? isFillWhite;
  final Function() onTapButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DefaultFormField2(
            controller: controller,
            maxLines: maxLines,
            suffixIcon: suffixIcon,
            enabled: enabled,
            readOnly: readOnly,
            isPassword: isPassword,
            hintText: hintText,
            suffixPadding: suffixPadding,
            textInputType: textInputType,
            onTap: onTap,
            onChange: onChange,
            validator: validator,
            isFillWhite: isFillWhite,
          ),
        ),
        SizedBox(width: 12,),
        DefaultRemoveButton(onTap: onTapButton)
      ],
    );
  }
}
