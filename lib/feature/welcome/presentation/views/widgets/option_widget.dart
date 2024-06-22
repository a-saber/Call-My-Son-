import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({super.key, required this.onTap, required this.widget, required this.text});
final Function() onTap;
final Widget widget;
final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          widget,
          SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: StyleManager.textStyle15,
          )
        ],
      ),
    );
  }
}
