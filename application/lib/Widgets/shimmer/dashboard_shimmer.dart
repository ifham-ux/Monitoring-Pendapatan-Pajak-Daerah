import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  Widget _shimmerBox({
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
            const SizedBox(height: 16),

            // Chart
            _shimmerBox(
              height: 250,
              radius: 16,
            ),

            const SizedBox(height: 19),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _shimmerBox(
                    height: 110,
                    radius: 8,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _shimmerBox(
                    height: 110,
                    radius: 8,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 26),

            // Progress Summary Title
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: AppColors.blackThree,
                  ),
                ),
                const SizedBox(width: 10),
                _shimmerBox(
                  width: 140,
                  height: 20,
                  radius: 4,
                ),
              ],
            ),

            const SizedBox(height: 23),

            ...List.generate(
              6,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blackThree,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _shimmerBox(
                          width: 120,
                          height: 18,
                          radius: 4,
                        ),
                        const Spacer(),
                        _shimmerBox(
                          width: 60,
                          height: 18,
                          radius: 4,
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    _shimmerBox(
                      height: 6,
                      radius: 30,
                    ),

                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: _shimmerBox(
                        width: 160,
                        height: 14,
                        radius: 4,
                      ),
                    ),
                  ],
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