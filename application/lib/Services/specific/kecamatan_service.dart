import 'package:flutter/material.dart';

import '../../Models/models.dart';
import '../cache_service.dart';
import '../services.dart';

class KecamatanService {

  static String _keyKelurahan(String kdKecamatan) => 'kecamatan_kelurahan_$kdKecamatan';
  static String _keyPercentage(int year, String kdKecamatan) => 'kecamatan_pct_${year}_$kdKecamatan';

  static Future<List<ListKelurahanJson>> loadKelurahan(String kdKelurahan) async {
    return CacheService.getOrFetch<List<ListKelurahanJson>>(
      key: _keyKelurahan(kdKelurahan),
      fetch: () async {
        try {
          return await ApiService.fetchListKelurahan("51", "71", kdKelurahan);
        } catch (e) {
          debugPrint(e.toString());
          return [];
        }
      },
      toJson: (list) => list.map((k) => k.toJson()).toList(),
      fromJson: (json) => (json as List)
          .map((e) => ListKelurahanJson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static Future<Map<String, dynamic>> loadPercentageData({
    required int selectedYear,
    required String kdKecamatan,
    required List<ListKelurahanJson> kelurahan,
  }) async {
    return CacheService.getOrFetch<Map<String, dynamic>>(
      key: _keyPercentage(selectedYear, kdKecamatan),
      fetch: () => _fetchPercentageData(
        selectedYear: selectedYear,
        kdKecamatan: kdKecamatan,
        kelurahan: kelurahan,
      ),
      toJson: (data) => {
        'tempPercentage': (data['tempPercentage'] as Map).map((k, v) => MapEntry(k, v)),
        'totalSudahBayarMap': (data['totalSudahBayarMap'] as Map).map((k, v) => MapEntry(k, v)),
        'totalWajibPajakMap': (data['totalWajibPajakMap'] as Map).map((k, v) => MapEntry(k, v)),
        'totalPbbTerhutangMap': (data['totalPbbTerhutangMap'] as Map).map((k, v) => MapEntry(k, v)),
        'totalRealisasiPbbMap': (data['totalRealisasiPbbMap'] as Map).map((k, v) => MapEntry(k, v)),
        // detailsMap berisi ListDetailsRow — tidak di-cache karena terlalu besar
        // kalau perlu di-cache, serialize masing-masing field
      },
      fromJson: (json) {
        final m = json as Map<String, dynamic>;
        return {
          'tempPercentage': Map<String, double>.from(
            (m['tempPercentage'] as Map).map((k, v) => MapEntry(k as String, (v as num).toDouble())),
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
          'detailsMap': <String, List<dynamic>>{},
        };
      },
    );
  }

  static Future<Map<String, dynamic>> _fetchPercentageData({
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

    await Future.wait(kelurahan.map((item) async {
      try {
        int totalWajibPajak = 0;
        int totalSudahBayar = 0;
        int totalTerhutang = 0;
        int totalRealisasi = 0;

        if (selectedYear == 2026) {
          final detailsResult = await ApiService.fetchListDetails(
            "51", "71", kdKecamatan, item.kdKelurahan, 100, 0,
          );
          totalWajibPajak = detailsResult.length;
          detailsMap[item.kdKelurahan] = detailsResult;

          final spptResult = await ApiService.fetchListSppt(
            selectedYear, "51", "71", kdKecamatan, item.kdKelurahan, '', 100, 0,
          );
          totalSudahBayar = spptResult.where((e) => e.statusPembayaranSppt == 1).length;
          for (final sppt in spptResult) {
            totalTerhutang += sppt.pbbTerhutangSppt.toInt();
            if (sppt.statusPembayaranSppt == 1) totalRealisasi += sppt.pbbTerhutangSppt.toInt();
          }
        } else {
          final spptResult = await ApiService.fetchListSppt(
            selectedYear, "51", "71", kdKecamatan, item.kdKelurahan, '', 100, 0,
          );
          totalWajibPajak = spptResult.length;
          totalSudahBayar = spptResult.where((e) => e.statusPembayaranSppt == 1).length;
          for (final sppt in spptResult) {
            totalTerhutang += sppt.pbbTerhutangSppt.toInt();
            if (sppt.statusPembayaranSppt == 1) totalRealisasi += sppt.pbbTerhutangSppt.toInt();
          }
        }

        final double percentage = totalWajibPajak > 0
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
    }));

    return {
      'tempPercentage': tempPercentage,
      'totalSudahBayarMap': totalSudahBayarMap,
      'totalWajibPajakMap': totalWajibPajakMap,
      'totalPbbTerhutangMap': totalPbbTerhutangMap,
      'totalRealisasiPbbMap': totalRealisasiPbbMap,
      'detailsMap': detailsMap,
    };
  }
}
