import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:flutter/material.dart';

class DefaultCheckBox extends StatelessWidget {
  const DefaultCheckBox({super.key, required this.checkVal, required this.onChanged, required this.text});
  final bool checkVal;
  final Function(bool?) onChanged;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: ColorsManager.primary,
          value: checkVal,
          onChanged:onChanged,
        ),
        SizedBox(width: 30,),
        Text(text,style: StyleManager.textStyle18,),
      ],
    );
  }
}
