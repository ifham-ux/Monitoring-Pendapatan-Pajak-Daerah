import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class HistoryCardShimmer extends StatelessWidget {
  const HistoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.blackThree,
      highlightColor: AppColors.whiteThree.withOpacity(.15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.blackThree,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [

            Row(
              children: [

                Container(
                  width: 70,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.blackThree,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const Spacer(),

                Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.blackThree,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Container(
              height: 2,
              color: AppColors.blackThree,
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.blackThree,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                Expanded(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.blackThree,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                Container(
                  width: 90,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.blackThree,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}