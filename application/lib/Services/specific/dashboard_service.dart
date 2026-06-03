import 'dart:convert';

import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/cache_service.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';

class DashboardService {

  // ── Cache keys ─────────────────────────────────────────────────────────────
  static String _keyDashboard(int year) => 'dashboard_data_$year';
  static String _keyKecamatanOverview(int year) => 'dashboard_kecamatan_$year';

  // ──────────────────────────────────────────────────────────────────────────
  // loadDashboardData — data chart + ringkasan global
  // ──────────────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> loadDashboardData(int year) async {

    // Untuk tahun berjalan (2026) hasilnya selalu 0, tidak perlu cache
    if (year == 2026) {
      return {
        "totalWajibPajak": 0,
        "totalSudahBayar": 0,
        "totalTarget": 0,
        "totalRealisasi": 0,
        "percentage": 0.0,
        "chartData": List.generate(
          12,
          (i) => DashboardChartData(month: i + 1, target: 0, realisasi: 0),
        ),
      };
    }

    return CacheService.getOrFetch<Map<String, dynamic>>(
      key: _keyDashboard(year),
      fetch: () => _fetchDashboardData(year),
      toJson: (data) => {
        'totalWajibPajak': data['totalWajibPajak'],
        'totalSudahBayar': data['totalSudahBayar'],
        'totalTarget': data['totalTarget'],
        'totalRealisasi': data['totalRealisasi'],
        'percentage': data['percentage'],
        'chartData': (data['chartData'] as List<DashboardChartData>)
            .map((e) => {'month': e.month, 'target': e.target, 'realisasi': e.realisasi})
            .toList(),
      },
      fromJson: (json) {
        final m = json as Map<String, dynamic>;
        return {
          'totalWajibPajak': m['totalWajibPajak'],
          'totalSudahBayar': m['totalSudahBayar'],
          'totalTarget': m['totalTarget'],
          'totalRealisasi': m['totalRealisasi'],
          'percentage': (m['percentage'] as num).toDouble(),
          'chartData': (m['chartData'] as List).map((e) {
            final em = e as Map<String, dynamic>;
            return DashboardChartData(
              month: em['month'] as int,
              target: (em['target'] as num).toDouble(),
              realisasi: (em['realisasi'] as num).toDouble(),
            );
          }).toList(),
        };
      },
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // loadKecamatanOverview — persentase per kecamatan
  // ──────────────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> loadKecamatanOverview(int selectedYear) async {
    return CacheService.getOrFetch<Map<String, dynamic>>(
      key: _keyKecamatanOverview(selectedYear),
      fetch: () => _fetchKecamatanOverview(selectedYear),
      toJson: (data) {
        final kecamatan = data['kecamatan'] as List<ListKecamatanJson>;
        return {
          'kecamatan': kecamatan.map((k) => jsonDecode(jsonEncode({
            'kdKecamatan': k.kdKecamatan,
            'nmKecamatan': k.nmKecamatan,
          }))).toList(),
          'totalSudahBayarMap': data['totalSudahBayarMap'],
          'totalWajibPajakMap': data['totalWajibPajakMap'],
          'percentageMap': data['percentageMap'],
        };
      },
      fromJson: (json) {
        final m = json as Map<String, dynamic>;
        return {
          'kecamatan': (m['kecamatan'] as List).map((e) {
            return ListKecamatanJson.fromJson(e as Map<String, dynamic>);
          }).toList(),
          'totalSudahBayarMap': Map<String, int>.from(
            (m['totalSudahBayarMap'] as Map).map((k, v) => MapEntry(k as String, (v as num).toInt())),
          ),
          'totalWajibPajakMap': Map<String, int>.from(
            (m['totalWajibPajakMap'] as Map).map((k, v) => MapEntry(k as String, (v as num).toInt())),
          ),
          'percentageMap': Map<String, double>.from(
            (m['percentageMap'] as Map).map((k, v) => MapEntry(k as String, (v as num).toDouble())),
          ),
        };
      },
    );
  }

  // ── Internal fetch (tanpa cache) ──────────────────────────────────────────

  static Future<Map<String, dynamic>> _fetchDashboardData(int year) async {
    final kecamatan = await ApiService.fetchListKecamatan("51", "71");

    int totalWajibPajak = 0;
    int totalSudahBayar = 0;
    int totalTarget = 0;
    int totalRealisasi = 0;
    final List<double> monthlyRealisasi = List.filled(12, 0);

    for (final kcm in kecamatan) {
      final spptList = await ApiService.fetchListSppt(
        year, "51", "71", kcm.kdKecamatan, "", "", 100, 0,
      );

      totalWajibPajak += spptList.length;
      totalSudahBayar += spptList.where((e) => e.statusPembayaranSppt == 1).length;

      for (final sppt in spptList) {
        totalTarget += sppt.pbbTerhutangSppt;
        if (sppt.statusPembayaranSppt == 1) {
          totalRealisasi += sppt.pbbTerhutangSppt;
          final date = sppt.tglTerbitSppt;
          if (date != null) {
            monthlyRealisasi[date.month - 1] += sppt.pbbTerhutangSppt.toDouble();
          }
        }
      }
    }

    final List<double> cumulativeRealisasi = List.filled(12, 0);
    for (int i = 0; i < 12; i++) {
      cumulativeRealisasi[i] = i == 0
          ? monthlyRealisasi[i]
          : cumulativeRealisasi[i - 1] + monthlyRealisasi[i];
    }

    final chartData = List.generate(12, (index) => DashboardChartData(
      month: index + 1,
      target: totalTarget.toDouble(),
      realisasi: cumulativeRealisasi[index],
    ));

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

  static Future<Map<String, dynamic>> _fetchKecamatanOverview(int selectedYear) async {
    final kecamatan = await ApiService.fetchListKecamatan("51", "71");

    final Map<String, int> totalSudahBayarMap = {};
    final Map<String, int> totalWajibPajakMap = {};
    final Map<String, double> percentageMap = {};

    for (final item in kecamatan) {
      final result = await ApiService.fetchListSppt(
        selectedYear, "51", "71", item.kdKecamatan, "", "", 100, 0,
      );

      final totalWajibPajak = result.length;
      final totalSudahBayar = result.where((e) => e.statusPembayaranSppt == 1).length;
      final percentage = totalWajibPajak == 0
          ? 0.0
          : (totalSudahBayar / totalWajibPajak) * 100;

      totalSudahBayarMap[item.kdKecamatan] = totalSudahBayar;
      totalWajibPajakMap[item.kdKecamatan] = totalWajibPajak;
      percentageMap[item.kdKecamatan] = percentage;
    }

    return {
      "kecamatan": kecamatan,
      "totalSudahBayarMap": totalSudahBayarMap,
      "totalWajibPajakMap": totalWajibPajakMap,
      "percentageMap": percentageMap,
    };
  }
}