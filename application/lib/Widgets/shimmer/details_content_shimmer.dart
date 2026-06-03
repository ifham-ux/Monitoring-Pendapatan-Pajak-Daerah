import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class DetailsContentShimmer extends StatelessWidget {
  const DetailsContentShimmer({super.key});

  Widget box({
    double height = 20,
    double width = double.infinity,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.blackThree,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.blackThree,
      highlightColor: AppColors.whiteThree.withOpacity(.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(height: 42),

            box(width: 120, height: 16),


            const SizedBox(height: 20),

            box(width: 500, height: 40),

            SizedBox(height: 20),

            box(width: 80, height: 40),

            const SizedBox(height: 30),

            // Biodata
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.blackThree,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  box(height: 16),
                  const SizedBox(height: 12),
                  box(height: 18),

                  const SizedBox(height: 24),

                  box(height: 16),
                  const SizedBox(height: 12),
                  box(height: 18),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // View Summary button
            box(height: 50),

            const SizedBox(height: 24),
            Divider(),

            const SizedBox(height: 24),

            // Detail cards
            box(width: double.infinity, height: 500),


          ],
        ),
      ),
    );
  }
}