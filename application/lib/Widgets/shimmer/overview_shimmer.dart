import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class OverviewCardShimmer extends StatelessWidget {
  const OverviewCardShimmer({super.key});

  Widget _box({
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.blackThree,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.blackThree,
      highlightColor: AppColors.whiteThree.withOpacity(.15),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.blackThree,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Tahun + Status
            Row(
              children: [
                _box(
                  width: 70,
                  height: 12,
                ),

                const Spacer(),

                Container(
                  width: 70,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.blackThree,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            const Divider(
              color: AppColors.blackFour,
              thickness: 2,
            ),

            const SizedBox(height: 8),

            // NOP label
            _box(
              width: 90,
              height: 11,
            ),

            const SizedBox(height: 6),

            // NOP value
            _box(
              width: double.infinity,
              height: 15,
            ),

            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      _box(
                        width: 110,
                        height: 11,
                      ),

                      const SizedBox(height: 6),

                      _box(
                        width: 140,
                        height: 12,
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    _box(
                      width: 70,
                      height: 11,
                    ),

                    const SizedBox(height: 6),

                    _box(
                      width: 90,
                      height: 12,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}