import 'package:flutter/material.dart';

import '../../Models/models.dart';
import '../cache_service.dart';
import '../services.dart';

class OverdueService {

  static String _keyOverdue(int year) => 'overdue_list_$year';
  static String _keyPercentage(int year) => 'overdue_pct_$year';

  static Future<List<OverdueItem>> fetchOverdue(int selectedYear) async {
    return CacheService.getOrFetch<List<OverdueItem>>(
      key: _keyOverdue(selectedYear),
      fetch: () async {
        final rows = await ApiService.fetchListSppt(
          selectedYear, '51', '71', '', '', '0', 100, 0,
        );
        return rows.map((e) => OverdueItem.fromSppt(e)).toList();
      },
      toJson: (list) => list.map((e) => e.toJson()).toList(),
      fromJson: (json) => (json as List)
          .map((e) => OverdueItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static Future<Map<String, dynamic>> loadPercentageData({
    required int selectedYear,
    required List<ListKecamatanJson> kecamatan,
  }) async {
    if (selectedYear == 2026) {
      return _emptyResult(kecamatan);
    }

    return CacheService.getOrFetch<Map<String, dynamic>>(
      key: _keyPercentage(selectedYear),
      fetch: () => _fetchPercentageData(selectedYear: selectedYear, kecamatan: kecamatan),
      toJson: (data) => {
        'percentageMap': (data['percentageMap'] as Map).map((k, v) => MapEntry(k, v)),
        'totalSudahBayarMap': (data['totalSudahBayarMap'] as Map).map((k, v) => MapEntry(k, v)),
        'totalWajibPajakMap': (data['totalWajibPajakMap'] as Map).map((k, v) => MapEntry(k, v)),
        'totalPbbTerhutangMap': (data['totalPbbTerhutangMap'] as Map).map((k, v) => MapEntry(k, v)),
        'totalRealisasiPbbMap': (data['totalRealisasiPbbMap'] as Map).map((k, v) => MapEntry(k, v)),
        'totalAllWajibPajak': data['totalAllWajibPajak'],
        'totalAllSudahBayar': data['totalAllSudahBayar'],
        'overallPercentage': data['overallPercentage'],
        'totalAllPbbTerhutang': data['totalAllPbbTerhutang'],
        'totalAllRealisasiPbb': data['totalAllRealisasiPbb'],
      },
      fromJson: (json) {
        final m = json as Map<String, dynamic>;
        return {
          'percentageMap': Map<String, double>.from(
            (m['percentageMap'] as Map).map((k, v) => MapEntry(k as String, (v as num).toDouble())),
          ),
          'totalSudahBayarMap': Map<String, int>.from(
            (m['totalSudahBayarMap'] as Map).map((k, v) => MapEntry(k as String, (v as num).toInt())),
          ),
          'totalWajibPajakMap': Map<String, int>.from(
            (m['totalWajibPajakMap'] as Map).map((k, v) => MapEntry(k as String, (v as num).toInt())),
          ),
          'totalPbbTerhutangMap': Map<String, int>.from(
            (m['totalPbbTerhutangMap'] as Map).map((k, v) => MapEntry(k as String, (v as num).toInt())),
          ),
          'totalRealisasiPbbMap': Map<String, int>.from(
            (m['totalRealisasiPbbMap'] as Map).map((k, v) => MapEntry(k as String, (v as num).toInt())),
          ),
          'totalAllWajibPajak': (m['totalAllWajibPajak'] as num).toInt(),
          'totalAllSudahBayar': (m['totalAllSudahBayar'] as num).toInt(),
          'overallPercentage': (m['overallPercentage'] as num).toDouble(),
          'totalAllPbbTerhutang': (m['totalAllPbbTerhutang'] as num).toInt(),
          'totalAllRealisasiPbb': (m['totalAllRealisasiPbb'] as num).toInt(),
        };
      },
    );
  }

  static Future<Map<String, dynamic>> _fetchPercentageData({
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

      for (final item in kecamatan) {
        try {
          final result = await ApiService.fetchListSppt(
            selectedYear, "51", "71", item.kdKecamatan, "", "", 100, 0,
          );
          final totalWajibPajak = result.length;
          final totalSudahBayar = result.where((e) => e.statusPembayaranSppt == 1).length;
          int totalPbbTerhutang = 0;
          int totalRealisasiPbb = 0;
          for (final sppt in result) {
            totalPbbTerhutang += sppt.pbbTerhutangSppt;
            if (sppt.statusPembayaranSppt == 1) totalRealisasiPbb += sppt.pbbTerhutangSppt;
          }
          double percentage = totalWajibPajak > 0
              ? (totalSudahBayar / totalWajibPajak) * 100
              : 0;
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
          tempPercentage[item.kdKecamatan] = 0.0;
          totalPbbTerhutangMap[item.kdKecamatan] = 0;
          totalRealisasiPbbMap[item.kdKecamatan] = 0;
          totalSudahBayarMap[item.kdKecamatan] = 0;
          totalWajibPajakMap[item.kdKecamatan] = 0;
        }
      }

      double overallPercentage = globalWajibPajak > 0
          ? (globalSudahBayar / globalWajibPajak) * 100
          : 0;

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

  static Map<String, dynamic> _emptyResult(List<ListKecamatanJson> kecamatan) {
    final Map<String, double> pct = {};
    final Map<String, int> zero = {};
    for (final item in kecamatan) {
      pct[item.kdKecamatan] = 0.0;
      zero[item.kdKecamatan] = 0;
    }
    return {
      "percentageMap": pct,
      "totalSudahBayarMap": Map<String, int>.from(zero),
      "totalWajibPajakMap": Map<String, int>.from(zero),
      "totalPbbTerhutangMap": Map<String, int>.from(zero),
      "totalRealisasiPbbMap": Map<String, int>.from(zero),
      "totalAllWajibPajak": 0,
      "totalAllSudahBayar": 0,
      "overallPercentage": 0.0,
      "totalAllPbbTerhutang": 0,
      "totalAllRealisasiPbb": 0,
    };
  }
}