import 'package:flutter/material.dart';

import '../../Models/models.dart';

// ignore: unused_import

import '../services.dart';

class ActivityService {

  static Future<List<ListKecamatanJson>> loadKecamatan() async {
    try {
      final result = await ApiService.fetchListKecamatan(
        "51",
        "71",
      );
      return result;

    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<Map<String, dynamic>>
  loadDetailsCounts(List<ListKecamatanJson> kecamatan) async {

    try {
      Map<String, Map<String, int>> tempMap = {};
      int globalTotalWajibPajak = 0;

      for (final kecamatanItem in kecamatan) {

        int totalWajibPajak = 0;
        int totalKelurahan = 0;

        final kelurahanResult = await ApiService.fetchListKelurahan(
          "51",
          "71",
          kecamatanItem.kdKecamatan,
        );
        totalKelurahan = kelurahanResult.length;

        for (final kelurahanItem in kelurahanResult) {
          try {
            final detailsResult = await ApiService.fetchListDetails(
              "51",
              "71",
              kecamatanItem.kdKecamatan,
              kelurahanItem.kdKelurahan,
              100,
              0,
            );

            totalWajibPajak += detailsResult.length;
            globalTotalWajibPajak += detailsResult.length;

          } catch (e) {
            debugPrint(e.toString());
          }
        }
        tempMap[kecamatanItem.kdKecamatan] = {
          "wajibPajak": totalWajibPajak,
          "kelurahan": totalKelurahan,
        };
      }
      return {
        "detailsCountMap": tempMap,
        "jumlahSedangDidata2026": globalTotalWajibPajak,
      };
    } catch (e) {
      debugPrint(e.toString());
      return {
        "detailsCountMap": <String, Map<String, int>>{},
        "jumlahSedangDidata2026": 0,
      };
    }
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