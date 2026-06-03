import 'package:flutter/material.dart';
import 'app_gradient.dart';

String getBackgroundImage(double percentage) {

  if (percentage >= 50) {
    return 'assets/iconImage/bg2026-blue.png';

  } else {
    return 'assets/iconImage/bg2026-red.png';
  }
}

LinearGradient getPercentageGradient(double percentage) {
  if (percentage >= 50) {
    return AppGradient.yesyes;
  } 
  
  else {
    return AppGradient.nono;
  }
}