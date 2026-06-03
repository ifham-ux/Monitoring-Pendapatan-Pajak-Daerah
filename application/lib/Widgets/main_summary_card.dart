import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class MainSummaryCard extends StatelessWidget {

  final double overallPercentage;
  final int totalSudahBayar;
  final int totalWajibPajak;
  final int totalRealisasiPbb;
  final int totalPbbTerhutang;
  final int isCurrentYear;

  const MainSummaryCard({
    super.key,
    required this.overallPercentage,
    required this.totalSudahBayar,
    required this.totalWajibPajak,
    required this.totalRealisasiPbb,
    required this.totalPbbTerhutang,
    required this.isCurrentYear,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 135,
            clipBehavior: Clip.hardEdge,

            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: AppColors.blackThree,
              borderRadius: BorderRadius.circular(12),

              image: DecorationImage(
                image: AssetImage(getBackgroundImage(overallPercentage)),
                fit: BoxFit.cover,
              ),
              boxShadow: getOverviewShadow(overallPercentage),
            ),

              child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -40,
                  top: 0,
                  child: Opacity(
                    opacity: 0.04,
                    child: Text(
                      isCurrentYear.toString(),
                      style: const TextStyle (
                        fontSize: 130,
                        fontFamily: 'PlusJakartaSans',
                        color: AppColors.blackOne
                      ),
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),

                            child: LinearProgressIndicator(
                              minHeight: 12,
                              value: overallPercentage / 100,
                              backgroundColor: Colors.black.withValues(alpha: 0.3),
                              valueColor: const AlwaysStoppedAnimation(Colors.black),
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Text(
                          '${overallPercentage.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: AppColors.blackOne,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Text(
                          '$totalSudahBayar / $totalWajibPajak',

                          style: const TextStyle(
                            color: AppColors.blackOne,
                            fontSize: 13,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),

                        const Spacer(),

                        Text(
                          isCurrentYear == 2026? "-"
                          : "${formatCurrency(totalRealisasiPbb)} / "
                            "${formatCurrency(totalPbbTerhutang)}",

                          style: const TextStyle(
                            color: AppColors.blackOne,
                            fontSize: 13,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


List<BoxShadow> getOverviewShadow(double percentage) {
  if (percentage >= 50) {
    return [
      BoxShadow(
        color: const Color(0xFF82FFAE).withValues(alpha: 0.3),
        blurRadius: 30,
        offset: const Offset(-5, 0),
      ),

      BoxShadow(
        color: const Color(0xFF2894CA).withValues(alpha: 0.4),
        blurRadius: 40,
        offset: const Offset(5, 8),
      ),
    ];
  }

  return [
    BoxShadow(
      color: const Color(0xFFFFBB00).withValues(alpha: 0.3),
      blurRadius: 30,
      offset: const Offset(-5, 0),
    ),

    BoxShadow(
      color: const Color(0xFFCA2828).withValues(alpha: 0.4),
      blurRadius: 40,
      offset: const Offset(5, 8),
    ),
  ];
}