import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

class DashboardLineChart extends StatelessWidget {

  final List<DashboardChartData> data;

  const DashboardLineChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {

    if (data.isEmpty) {
      return Container(
        height: 350,
        alignment: Alignment.center,

        child: const Text(
          "No Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),

      decoration: BoxDecoration(
        gradient: AppGradient.yesyes,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
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
          ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            "Grafik Tren",
            style: TextStyle(
              color: AppColors.blackOne,
              fontSize: 24,
              fontFamily: 'PlusJakartaSans',
            ),
          ),

          Row(
            children: [

              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.blackOne,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 8),

              const Text(
                "Target",
                style: TextStyle(
                  color: AppColors.blackOne,
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 12,
                ),
              ),

              const SizedBox(width: 20),

              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.whiteOne,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 8),

              const Text(
                "Realisasi",
                style: TextStyle(
                  color: AppColors.blackOne,
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 12,
                ),
              ),
            ],
          ),

          
          const SizedBox(height: 20),

          SizedBox(
            height: 150,

            child: LineChart(
              _buildChartData(),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  LineChartData _buildChartData() {


    return LineChartData(
      minX: 0,
      maxX: 11,

      minY: 0,
      maxY: 80000000,

      borderData: FlBorderData(
        show: true,

        border: Border(
          top: BorderSide(
            color: AppColors.blackOne.withValues(alpha: 0.3),
            width: 2,
          ),

          bottom: BorderSide(
            color: AppColors.blackOne.withValues(alpha: 0.3),
            width: 2,
          ),

          left: BorderSide.none,
          right: BorderSide.none,
        ),
      ),

      gridData: FlGridData(
        show: true,

        drawVerticalLine: false,

        horizontalInterval: 20000000,

        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.blackOne.withValues(alpha: 0.3),
            strokeWidth: 2,
          );
        },
      ),

      titlesData: FlTitlesData(

        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,

            getTitlesWidget:
                (value, meta) {

              const months = [

                'Ja',
                'Fb',
                'Mr',
                'Ap',
                'My',
                'Jn',
                'Jl',
                'Ag',
                'Sp',
                'Ok',
                'Nv',
                'Ds',
              ];

              if (value < 0 ||
                  value > 11) {
                return const SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                ),

                child: Text(
                  months[value.toInt()],

                  style: const TextStyle(
                    color: AppColors.blackOne,
                    fontSize: 11,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              );
            },
          ),
        ),

        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,

            interval: 20000000,

            getTitlesWidget: (value, meta) {
              return Text(
                formatCurrencyCompact(value),
                style: const TextStyle(
                    color: AppColors.blackOne,
                    fontSize: 10,
                    fontFamily: 'PlusJakartaSans',
                  ),
              );
            },
          ),
        ),
      ),

      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (spot) {
            return AppColors.whiteOne.withValues(alpha: 0.7);
          },

          getTooltipItems: (touchedSpots) {

            return touchedSpots.map(
              (spot) {
                return LineTooltipItem(
                  formatCurrency(
                    spot.y,
                  ),
                  const TextStyle(
                    color: AppColors.blackOne,
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10,
                  ),
                );
              },
            ).toList();
          },
        ),
      ),

      lineBarsData: [

        LineChartBarData(
          isCurved: true,
          color: AppColors.blackOne,
          barWidth: 3,

          dotData: const FlDotData(
            show: true,
          ),

          spots: data
              .asMap()
              .entries
              .map(
                (entry) => FlSpot(
                  entry.key.toDouble(),
                  entry.value.target,
                ),
              )
              .toList(),
        ),

        /// REALISASI

        LineChartBarData(

          isCurved: true,
          color: AppColors.whiteOne,
          barWidth: 3,

          dotData: const FlDotData(
            show: true,
          ),

          spots: data
              .asMap()
              .entries
              .map(
                (entry) => FlSpot(
                  entry.key.toDouble(),
                  entry.value.realisasi,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  String formatCurrencyCompact(double value) {
    if (value >= 1000000000) {
      return 'Rp ${(value / 1000000000).toStringAsFixed(0)}B';
    }

    if (value >= 1000000) {
      return 'Rp ${(value / 1000000).toStringAsFixed(0)}M';
    }

    if (value >= 1000) {
      return 'Rp ${(value / 1000).toStringAsFixed(0)}K';
    }

    return 'Rp ${value.toStringAsFixed(0)}';
  }

}