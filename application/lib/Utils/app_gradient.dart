import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradient {
  static const LinearGradient yesyes = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,

    colors: [
      AppColors.green,
      AppColors.blue
    ],
  );

  static const LinearGradient nono = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,

    colors: [
      AppColors.red,
      AppColors.orange
    ]
  );

  static const LinearGradient mid = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,

    colors: [
      AppColors.darkerYellow,
      AppColors.yellow
    ]
  );
}