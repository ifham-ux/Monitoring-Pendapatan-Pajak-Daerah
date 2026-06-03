import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:flutter/material.dart';


class Section extends StatelessWidget {
  final String title;
  final String value;

  const Section({
    super.key,
    required this.title, 
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: AppGradient.yesyes,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF82FFAE).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(-5, 0),
          ),

          BoxShadow(
            color: const Color(0xFF2894CA).withValues(alpha: 0.4),
            blurRadius: 14,
            offset: const Offset(5, 8),
          ),
        ]

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.blackOne,
                fontSize: 18,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),

          SizedBox(height: 8),

          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.blackOne,
                fontSize: 24,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          )
        ],
      ),
    );
  }
}