import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class DelayManager {
  // splash body
  static const Duration durationSplashAnimation = Duration(milliseconds: 750);
  static Tween<Offset> tweenSplashAnimation =
      Tween<Offset>(begin: const Offset(-6, 0), end: Offset.zero);

  // splash to home
  static const Duration durationSplashToHome = Duration(milliseconds: 1500);
  static const Transition transitionSplashToHome = Transition.fadeIn;
  static const int timeTransitionSplashToHome = 1;
  static const Duration durationTransitionSplashToHome =
      Duration(seconds: timeTransitionSplashToHome);

  // home to screen
  static const Transition transitionToBookDetails = Transition.downToUp;
  static const Duration durationTransitionToBookDetails =
      Duration(milliseconds: 500);
}
