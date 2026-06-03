import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class PaginationShimmer extends StatelessWidget {
  const PaginationShimmer({super.key});

  Widget shimmerBox({
    required double width,
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
      highlightColor: AppColors.whiteThree.withOpacity(.12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 30),

          /// HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                shimmerBox(
                  width: 120,
                  height: 24,
                ),

                const SizedBox(height: 10),

                shimmerBox(
                  width: 220,
                  height: 38,
                ),

                const SizedBox(height: 10),

                shimmerBox(
                  width: 180,
                  height: 16,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// STAT CARDS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 135,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 15),
                itemBuilder: (_, __) {
                  return shimmerBox(
                    width: 115,
                    height: 135,
                    radius: 14,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// SEARCH BOX
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: shimmerBox(
              width: double.infinity,
              height: 56,
              radius: 16,
            ),
          ),

          const SizedBox(height: 24),

          /// OVERVIEW CARD LIST
          ...List.generate(
            4,
            (_) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: shimmerBox(
                width: double.infinity,
                height: 120,
                radius: 16,
              ),
            ),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }
}