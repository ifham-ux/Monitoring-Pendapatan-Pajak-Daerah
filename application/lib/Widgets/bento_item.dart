import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

Widget bentoItem({
  required String title,
  required String value,
  required double width,
}) {
  return Container(
    width: width,
    padding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 11
    ),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 25, 25, 25),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.whiteTwo,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.isEmpty ? '-' : value,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.whiteOne,
            fontWeight: FontWeight.w600,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ],
    ),
  );
}