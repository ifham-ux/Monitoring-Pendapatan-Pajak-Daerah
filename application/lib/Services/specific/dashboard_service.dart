import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';

class DashboardService {

  static Future<Map<String, dynamic>>
  loadDashboardData(int year) async {

    if (year == 2026) {
      return {
        "totalWajibPajak": 0,
        "totalSudahBayar": 0,
        "totalTarget": 0,
        "totalRealisasi": 0,
        "percentage": 0.0,
        "chartData": List.generate(
          12,
          (i) => DashboardChartData(
            month: i + 1,
            target: 0,
            realisasi: 0,
          ),
        ),
      };
    }

    final kecamatan =
      await ApiService.fetchListKecamatan(
        "51",
        "71",
      );

    int totalWajibPajak = 0;
    int totalSudahBayar = 0;
    int totalTarget = 0;
    int totalRealisasi = 0;

    // Realisasi per bulan berdasarkan tglTerbitSppt
    final List<double> monthlyRealisasi =
      List.filled(12, 0);

    for (final kcm in kecamatan) {

      final spptList =
        await ApiService.fetchListSppt(
          year,
          "51",
          "71",
          kcm.kdKecamatan,
          "",
          "",
          100,
          0,
        );

      totalWajibPajak += spptList.length;

      totalSudahBayar += spptList
          .where((e) => e.statusPembayaranSppt == 1)
          .length;

      for (final sppt in spptList) {

        totalTarget += sppt.pbbTerhutangSppt;

        if (sppt.statusPembayaranSppt == 1) {
          totalRealisasi += sppt.pbbTerhutangSppt;

          // Map realisasi ke bulan berdasarkan tglTerbitSppt
          final date = sppt.tglTerbitSppt;
          if (date != null) {
            final monthIndex = date.month - 1;
            monthlyRealisasi[monthIndex] +=
              sppt.pbbTerhutangSppt.toDouble();
          }
        }
      }
    }

    final List<double> cumulativeRealisasi =
        List.filled(12, 0);

    for (int i = 0; i < 12; i++) {

      cumulativeRealisasi[i] =
          i == 0
              ? monthlyRealisasi[i]
              : cumulativeRealisasi[i - 1] +
                    monthlyRealisasi[i];
}

    final chartData = List.generate(
      12,
      (index) {

        return DashboardChartData(
          month: index + 1,

          // target tetap
          target: totalTarget.toDouble(),

          // realisasi kumulatif
          realisasi:
              cumulativeRealisasi[index],
        );
      },
    );

    double percentage = 0;
    if (totalWajibPajak > 0) {
      percentage = (totalSudahBayar / totalWajibPajak) * 100;
    }

    return {
      "totalWajibPajak": totalWajibPajak,
      "totalSudahBayar": totalSudahBayar,
      "totalTarget": totalTarget,
      "totalRealisasi": totalRealisasi,
      "percentage": percentage,
      "chartData": chartData,
    };
  }



  static Future<Map<String, dynamic>> loadKecamatanOverview(
    int selectedYear,
  ) async {

    final kecamatan = await ApiService.fetchListKecamatan(
      "51",
      "71",
    );

    final Map<String, int> totalSudahBayarMap = {};
    final Map<String, int> totalWajibPajakMap = {};
    final Map<String, double> percentageMap = {};

    for (final item in kecamatan) {

      final result = await ApiService.fetchListSppt(
        selectedYear,
        "51",
        "71",
        item.kdKecamatan,
        "",
        "",
        100,
        0,
      );

      final totalWajibPajak = result.length;

      final totalSudahBayar = result
          .where((e) => e.statusPembayaranSppt == 1)
          .length;

      final percentage = totalWajibPajak == 0
          ? 0.0
          : (totalSudahBayar / totalWajibPajak) * 100;

      totalSudahBayarMap[item.kdKecamatan] =
          totalSudahBayar;

      totalWajibPajakMap[item.kdKecamatan] =
          totalWajibPajak;

      percentageMap[item.kdKecamatan] =
          percentage;
    }

    return {
      "kecamatan": kecamatan,
      "totalSudahBayarMap": totalSudahBayarMap,
      "totalWajibPajakMap": totalWajibPajakMap,
      "percentageMap": percentageMap,
    };
  }
}