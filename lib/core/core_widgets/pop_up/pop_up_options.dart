import 'package:flutter/material.dart';

enum PopUpState { SUCCESS, ERROR, WARNING }

Color choosePopUpColor(PopUpState state) {
  Color color;
  switch (state) {
    case PopUpState.SUCCESS:
      color = Colors.green;
      break;
    case PopUpState.ERROR:
      color = Colors.red;
      break;
    case PopUpState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}