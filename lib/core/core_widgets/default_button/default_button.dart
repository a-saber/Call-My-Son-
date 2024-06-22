import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.onTap, required this.text});
final Function() onTap;
final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: ColorsManager.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(text,style: StyleManager.textStyle20.copyWith(
            color: ColorsManager.white,
          ),),
        ),
      ),
    );
  }
}
