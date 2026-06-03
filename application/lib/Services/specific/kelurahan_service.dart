import 'package:flutter/material.dart';

import '../services.dart';

class KelurahanService {

  static Future<Map<String, dynamic>> loadData({
    required int selectedYear,
    required String kdPropinsi,
    required String kdDati2,
    required String kdKecamatan,
    required String kdKelurahan,
  }) async {

    try {
      if (selectedYear == 2026) {
        final details = await ApiService.fetchListDetails(
          kdPropinsi,
          kdDati2,
          kdKecamatan,
          kdKelurahan,
          100,
          0,
        );

        return {
          'isDetails': true,
          'detailsList': details,
        };
      }

      final sppt = await ApiService.fetchListSppt(
        selectedYear,
        kdPropinsi,
        kdDati2,
        kdKecamatan,
        kdKelurahan,
        '',
        100,
        0,
      );

      return {
        'isDetails': false,
        'spptList': sppt,
      };

    } catch (e) {

      debugPrint(e.toString());

      return {
        'isDetails': false,
        'detailsList': [],
        'spptList': [],
      };
    }
  }
}