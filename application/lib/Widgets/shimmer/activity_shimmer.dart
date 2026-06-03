import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class ActivityPageShimmer extends StatelessWidget {
  const ActivityPageShimmer({super.key});

  Widget box({
    double? width,
    required double height,
    double radius = 12,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.blackThree,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.blackThree,
      highlightColor: AppColors.whiteThree.withOpacity(0.15),

      child: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: box(
                height: 170,
                radius: 20,
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: box(height: 90)),
                  const SizedBox(width: 15),
                  Expanded(child: box(height: 90)),
                  const SizedBox(width: 15),
                  Expanded(child: box(height: 90)),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: box(
                height: 56,
                radius: 16,
              ),
            ),

            const SizedBox(height: 23),

            ...List.generate(
              6,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.blackThree,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          box(width: 140, height: 18, radius: 4),
                          const Spacer(),
                          box(width: 60, height: 18, radius: 4),
                        ],
                      ),

                      const SizedBox(height: 16),

                      box(
                        height: 8,
                        radius: 50,
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: box(
                              height: 60,
                              radius: 10,
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: box(
                              height: 60,
                              radius: 10,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Row(
                        children: [
                          box(width: 120, height: 14, radius: 4),
                          const Spacer(),
                          box(width: 90, height: 14, radius: 4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}