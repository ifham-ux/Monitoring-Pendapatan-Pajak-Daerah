import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:flutter/material.dart';

class OverdueService {
  static Future<List<OverdueItem>> fetchOverdue(
    int selectedYear
  ) async {
    final rows = await ApiService.fetchListSppt(
      selectedYear,
      '51',
      '71',
      '',
      '',
      '0',
      100,
      0,
    );

    return rows
        .map((e) => OverdueItem.fromSppt(e))
        .toList();
  }


  static Future<Map<String, dynamic>> loadPercentageData({
    required int selectedYear,
    required List<ListKecamatanJson> kecamatan,
  }) async {
    try {
      int mainKcmTerhutangPbb = 0;
      int mainKcmRealisasiPbb = 0;

      Map<String, double> tempPercentage = {};
      Map<String, int> totalSudahBayarMap = {};
      Map<String, int> totalWajibPajakMap = {};
      Map<String, int> totalPbbTerhutangMap = {};
      Map<String, int> totalRealisasiPbbMap = {};

      int globalWajibPajak = 0;
      int globalSudahBayar = 0;

      if (selectedYear == 2026) {
        for (final item in kecamatan) {
          tempPercentage[item.kdKecamatan] = 0.0;
          totalPbbTerhutangMap[item.kdKecamatan] = 0;
          totalRealisasiPbbMap[item.kdKecamatan] = 0;
          totalSudahBayarMap[item.kdKecamatan] = 0;
          totalWajibPajakMap[item.kdKecamatan] = 0;
        }

      } else {
        for (final item in kecamatan) {
          try {
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
            final totalSudahBayar = result.where(
                  (e) => e.statusPembayaranSppt == 1).length;

            int totalPbbTerhutang = 0;
            int totalRealisasiPbb = 0;

            for (final sppt in result) {
              totalPbbTerhutang += sppt.pbbTerhutangSppt;
              if (sppt.statusPembayaranSppt == 1) {
                totalRealisasiPbb += sppt.pbbTerhutangSppt;
              }
            }

            double percentage = 0;
            if (totalWajibPajak > 0) {
              percentage = (totalSudahBayar / totalWajibPajak) * 100;
            }

            tempPercentage[item.kdKecamatan] = percentage;
            totalPbbTerhutangMap[item.kdKecamatan] = totalPbbTerhutang;
            totalRealisasiPbbMap[item.kdKecamatan] = totalRealisasiPbb;
            totalSudahBayarMap[item.kdKecamatan] = totalSudahBayar;
            totalWajibPajakMap[item.kdKecamatan] = totalWajibPajak;
            mainKcmTerhutangPbb += totalPbbTerhutang;
            mainKcmRealisasiPbb += totalRealisasiPbb;
            globalWajibPajak += totalWajibPajak;
            globalSudahBayar += totalSudahBayar;

          } catch (e) {
            debugPrint('Error ${item.nmKecamatan}: $e');

            totalPbbTerhutangMap[item.kdKecamatan] = 0;
            totalRealisasiPbbMap[item.kdKecamatan] = 0;
            tempPercentage[item.kdKecamatan] = 0.0;
            totalSudahBayarMap[item.kdKecamatan] = 0;
            totalWajibPajakMap[item.kdKecamatan] = 0;
          }
        }
      }
      double overallPercentage = 0;

      if (globalWajibPajak > 0) {
        overallPercentage = (globalSudahBayar / globalWajibPajak) * 100;
      }

      return {
        "percentageMap": tempPercentage,
        "totalSudahBayarMap": totalSudahBayarMap,
        "totalWajibPajakMap": totalWajibPajakMap,
        "totalPbbTerhutangMap": totalPbbTerhutangMap,
        "totalRealisasiPbbMap": totalRealisasiPbbMap,
        "totalAllWajibPajak": globalWajibPajak,
        "totalAllSudahBayar": globalSudahBayar,
        "overallPercentage": overallPercentage,
        "totalAllPbbTerhutang": mainKcmTerhutangPbb,
        "totalAllRealisasiPbb": mainKcmRealisasiPbb,
      };

    } catch (e) {
      debugPrint(e.toString());
      return {};
    }
  }

}