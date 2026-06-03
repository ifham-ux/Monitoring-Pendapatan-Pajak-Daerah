import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class StatCardsShimmer extends StatelessWidget {
  const StatCardsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (_, __) {
          return Shimmer.fromColors(
            baseColor: AppColors.blackThree,
            highlightColor: AppColors.whiteThree.withOpacity(.15),
            child: Container(
              width: 115,
              decoration: BoxDecoration(
                color: AppColors.blackThree,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          );
        },
      ),
    );
  }
}