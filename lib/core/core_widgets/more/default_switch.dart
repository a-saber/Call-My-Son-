import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:flutter/material.dart';

class DefaultSwitch extends StatelessWidget {
  const DefaultSwitch({super.key, required this.switchVal, required this.onChanged, required this.text});
final bool switchVal;
final Function(bool) onChanged;
final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,style: StyleManager.textStyle18,),
        Spacer(),
        Switch(
          activeColor: ColorsManager.primary,
          inactiveThumbColor: Colors.grey.shade300,
          inactiveTrackColor: Colors.grey.shade400,
          value: switchVal,
          onChanged:onChanged,
        )
      ],
    );
  }
}
