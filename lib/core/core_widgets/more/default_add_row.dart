import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:flutter/material.dart';

class DefaultAddRow extends StatelessWidget {
  const DefaultAddRow(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  final String text;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: StyleManager.textStyle18,
        ),
        Spacer(),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: ColorsManager.primary,
              size: 35,
            ),
        )
      ],
    );
  }
}
