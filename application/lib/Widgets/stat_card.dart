import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  final Color? color;
  final Gradient? gradient;
  final double? height;

  final double? width;

  final Color? titleColor;
  final double? titleSize;

  final Color? valueColor;
  final double? valueSize;

  final List<BoxShadow>? boxShadow;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.height,
    this.titleSize,
    this.valueSize,
    this.color,
    this.gradient,
    this.width,
    this.titleColor,
    this.valueColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 135,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: gradient == null
            ? color ?? AppColors.blackThree
            : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: boxShadow,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                color: titleColor ?? AppColors.whiteThree,
                fontSize: titleSize ?? 12,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),

          Spacer(),

          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              value,
              style: TextStyle(
                fontSize: valueSize ?? 35,
                color: valueColor ?? AppColors.whiteOne,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<BoxShadow> getStatCardShadow(double percentage) {
  if (percentage >= 50) {
    return [
      BoxShadow(
        color: const Color(0xFF82FFAE).withValues(alpha: 0.25),
        blurRadius: 20,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: const Color(0xFF2894CA).withValues(alpha: 0.35),
        blurRadius: 30,
        offset: const Offset(0, 6),
      ),
    ];
  }

  return [
    BoxShadow(
      color: const Color(0xFFFFBB00).withValues(alpha: 0.25),
      blurRadius: 20,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: const Color(0xFFCA2828).withValues(alpha: 0.35),
      blurRadius: 30,
      offset: const Offset(0, 6),
    ),
  ];
}