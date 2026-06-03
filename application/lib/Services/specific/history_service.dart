import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/api_service.dart';

class HistoryService {
  static Future<List<GetSpptHistoryJson>> loadHistory({
    required String kdPropinsi,
    required String kdDati2,
    required String kdKecamatan,
    required String kdKelurahan,
    required String kdBlok,
    required String noUrut,
    required String kdJnsOp,
  }) async {

    try {
      final result = await ApiService.fetchGetSpptHistory(
        kdPropinsi,
        kdDati2,
        kdKecamatan,
        kdKelurahan,
        kdBlok,
        noUrut,
        kdJnsOp
      );

      return result;
    } catch (e) {
      debugPrint('loadHistory error: $e');
      return [];
    }
  }
}

