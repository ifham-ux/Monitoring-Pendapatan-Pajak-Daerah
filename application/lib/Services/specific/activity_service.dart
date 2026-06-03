import 'package:flutter/material.dart';

import '../../Models/models.dart';
import '../cache_service.dart';
import '../services.dart';

class ActivityService {

  // ── Cache keys ─────────────────────────────────────────────────────────────
  static const String _keyKecamatan = 'activity_kecamatan';
  static String _keyDetailsCounts(int year) => 'activity_details_counts_$year';
  static String _keyPercentage(int year) => 'activity_percentage_$year';

  // ──────────────────────────────────────────────────────────────────────────
  // loadKecamatan
  // ──────────────────────────────────────────────────────────────────────────
  static Future<List<ListKecamatanJson>> loadKecamatan() async {
    return CacheService.getOrFetch<List<ListKecamatanJson>>(
      key: _keyKecamatan,
      fetch: () async {
        try {
          return await ApiService.fetchListKecamatan("51", "71");
        } catch (e) {
          debugPrint(e.toString());
          return [];
        }
      },
      toJson: (list) => list.map((k) => k.toJson()).toList(),
      fromJson: (json) => (json as List)
          .map((e) => ListKecamatanJson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // loadDetailsCounts — jumlah wajib pajak per kecamatan (data 2026)
  // TTL 30 menit karena data 2026 bisa berubah
  // ──────────────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> loadDetailsCounts(
      List<ListKecamatanJson> kecamatan) async {
    return CacheService.getOrFetch<Map<String, dynamic>>(
      key: _keyDetailsCounts(2026),
      ttl: const Duration(minutes: 30),
      fetch: () => _fetchDetailsCounts(kecamatan),
      toJson: (data) {
        final Map<String, Map<String, int>> detailsCountMap =
            data['detailsCountMap'] as Map<String, Map<String, int>>;
        return {
          'detailsCountMap': detailsCountMap.map(
            (k, v) => MapEntry(k, {'wajibPajak': v['wajibPajak'], 'kelurahan': v['kelurahan']}),
          ),
          'jumlahSedangDidata2026': data['jumlahSedangDidata2026'],
        };
      },
      fromJson: (json) {
        final m = json as Map<String, dynamic>;
        return {
          'detailsCountMap': (m['detailsCountMap'] as Map).map((k, v) {
            final vm = v as Map<String, dynamic>;
            return MapEntry(k as String, <String, int>{
              'wajibPajak': (vm['wajibPajak'] as num).toInt(),
              'kelurahan': (vm['kelurahan'] as num).toInt(),
            });
          }),
          'jumlahSedangDidata2026': (m['jumlahSedangDidata2026'] as num).toInt(),
        };
      },
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // loadPercentageData — persentase pembayaran per kecamatan
  // ──────────────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> loadPercentageData({
    required int selectedYear,
    required List<ListKecamatanJson> kecamatan,
  }) async {
    if (selectedYear == 2026) {
      return _emptyPercentageResult(kecamatan);
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

  // ── Internal fetch helpers ─────────────────────────────────────────────────

  static Future<Map<String, dynamic>> _fetchDetailsCounts(
      List<ListKecamatanJson> kecamatan) async {
    try {
      Map<String, Map<String, int>> tempMap = {};
      int globalTotalWajibPajak = 0;

      for (final kecamatanItem in kecamatan) {
        int totalWajibPajak = 0;
        int totalKelurahan = 0;

        final kelurahanResult = await ApiService.fetchListKelurahan(
          "51", "71", kecamatanItem.kdKecamatan,
        );
        totalKelurahan = kelurahanResult.length;

        for (final kelurahanItem in kelurahanResult) {
          try {
            final detailsResult = await ApiService.fetchListDetails(
              "51", "71", kecamatanItem.kdKecamatan, kelurahanItem.kdKelurahan, 100, 0,
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

  static Map<String, dynamic> _emptyPercentageResult(List<ListKecamatanJson> kecamatan) {
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