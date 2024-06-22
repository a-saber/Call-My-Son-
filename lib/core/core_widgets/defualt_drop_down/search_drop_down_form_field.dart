import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:flutter/material.dart';

class SearchDropDownFormField extends StatelessWidget {
  const SearchDropDownFormField(
      {Key? key, required this.controller, required this.text})
      : super(key: key);
  final TextEditingController controller;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: true,
      maxLines: null,
      cursorColor: ColorsManager.primary,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        hintText: 'Search ...',
        hintStyle: StyleManager.textStyle18,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ColorsManager.borderColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ColorsManager.borderColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorsManager.borderColor)),
      ),
    );
  }
}
