
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'style_manager.dart';

abstract class ConstantsManager
{
  static const String appTitle = 'Call Up';
  static const String fontFamily = 'Cairo';
  static ThemeData theme=ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorsManager.white,
      appBarTheme: AppBarTheme(
        color: ColorsManager.white,
        iconTheme: IconThemeData(color: ColorsManager.black),
        elevation: 0.0,
        titleTextStyle: StyleManager.textStyle18,
      )
  );

  static const schoolCollection = 'school';
  static const guardianCollection = 'guardian';
  static const kidsCollection = 'kid';
  static const callCollection = 'call';
  static const levelCollection = 'level';
}