import 'package:flutter/material.dart';

import '../../Models/models.dart';
import '../services.dart';

class KecamatanService {
  static Future<List<ListKelurahanJson>> loadKelurahan(String kdKelurahan) async {
    try {
      final result = await ApiService.fetchListKelurahan(
        "51",
        "71",
        kdKelurahan,
      );
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<Map<String, dynamic>> loadPercentageData({
    required int selectedYear,
    required String kdKecamatan,
    required List<ListKelurahanJson> kelurahan,
  }) async {
    final Map<String, double> tempPercentage = {};
    final Map<String, int> totalSudahBayarMap = {};
    final Map<String, int> totalWajibPajakMap = {};
    final Map<String, int> totalPbbTerhutangMap = {};
    final Map<String, int> totalRealisasiPbbMap = {};

    Map<String, List<ListDetailsRow>> detailsMap = {};

    await Future.wait(
      kelurahan.map((item) async {
        try {
          int totalWajibPajak = 0;
          int totalSudahBayar = 0;
          int totalTerhutang = 0;
          int totalRealisasi = 0;

          if (selectedYear == 2026) {
            final detailsResult = await ApiService.fetchListDetails(
              "51",
              "71",
              kdKecamatan,
              item.kdKelurahan,
              100,
              0,
            );
            totalWajibPajak = detailsResult.length;
            detailsMap[item.kdKelurahan] = detailsResult;

            final spptResult = await ApiService.fetchListSppt(
              selectedYear,
              "51",
              "71",
              kdKecamatan,
              item.kdKelurahan,
              '',
              100,
              0,
            );

            totalSudahBayar = spptResult
              .where((e) => e.statusPembayaranSppt == 1)
              .length;

            for (final sppt in spptResult) {
              totalTerhutang += sppt.pbbTerhutangSppt.toInt();
              if (sppt.statusPembayaranSppt == 1) {
                totalRealisasi += sppt.pbbTerhutangSppt.toInt();
              }
            }
          } 

          else {
            final spptResult = await ApiService.fetchListSppt(
              selectedYear,
              "51",
              "71",
              kdKecamatan,
              item.kdKelurahan,
              '',
              100,
              0,
            );
            totalWajibPajak = spptResult.length;

            totalSudahBayar = spptResult
              .where((e) => e.statusPembayaranSppt == 1)
              .length;
            
            for (final sppt in spptResult) {
              totalTerhutang += sppt.pbbTerhutangSppt.toInt();
              if (sppt.statusPembayaranSppt == 1) {
                totalRealisasi += sppt.pbbTerhutangSppt.toInt();
              }
            }
          }
          
          final double percentage =
              totalWajibPajak > 0
                  ? (totalSudahBayar / totalWajibPajak) * 100
                  : 0.0;

          tempPercentage[item.kdKelurahan] = percentage;
          totalPbbTerhutangMap[item.kdKelurahan] = totalTerhutang;
          totalRealisasiPbbMap[item.kdKelurahan] = totalRealisasi;
          totalSudahBayarMap[item.kdKelurahan] = totalSudahBayar;
          totalWajibPajakMap[item.kdKelurahan] = totalWajibPajak;
        } catch (e) {
          debugPrint('Error ${item.nmKelurahan}: $e');

          tempPercentage[item.kdKelurahan] = 0.0;
          totalPbbTerhutangMap[item.kdKelurahan] = 0;
          totalRealisasiPbbMap[item.kdKelurahan] = 0;
          totalSudahBayarMap[item.kdKelurahan] = 0;
          totalWajibPajakMap[item.kdKelurahan] = 0;
        }
      }),
    );

    return {
      'tempPercentage': tempPercentage,
      'totalSudahBayarMap': totalSudahBayarMap,
      'totalWajibPajakMap': totalWajibPajakMap,
      'totalPbbTerhutangMap': totalPbbTerhutangMap,
      'totalRealisasiPbbMap': totalRealisasiPbbMap,
      'detailsMap': detailsMap
    };
  }
}

