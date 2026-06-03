import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';

class DetailsService {

  static Future<DetailItem?> loadData({
    required int selectedYear,
    required String kdPropinsi,
    required String kdDati2,
    required String kdKecamatan,
    required String kdKelurahan,
    required String kdBlok,
    required String noUrut,
    required String kdJnsOp,

  }) async {

    try {
      if (selectedYear == 2026) {
        final nopData = await ApiService.fetchGetByNop(

          kdPropinsi,
          kdDati2,
          kdKecamatan,
          kdKelurahan,
          kdBlok,
          noUrut,
          kdJnsOp,
        );

        return DetailItem(
          nopData: nopData.json,
        );
      }

      final spptData = await ApiService.fetchGetTahunSppt(
        kdPropinsi,
        kdDati2,
        kdKecamatan,
        kdKelurahan,
        kdBlok,
        noUrut,
        kdJnsOp,
        selectedYear.toString(),
      );

      return DetailItem(
        spptData: spptData,
      );

    } catch (e) {
      debugPrint(e.toString());

      return null;
    }
  }


  static Future<GetByNopJson?> loadBiodata({
    required String kdPropinsi,
    required String kdDati2,
    required String kdKecamatan,
    required String kdKelurahan,
    required String kdBlok,
    required String noUrut,
    required String kdJnsOp,
  }) async {
    
    try {
      final result = await ApiService.fetchGetByNop(
        kdPropinsi,
        kdDati2,
        kdKecamatan,
        kdKelurahan,
        kdBlok,
        noUrut,
        kdJnsOp,
      );

      return result.json;
    } catch (e) {
      debugPrint('loadBiodata error: $e');
      return null;
    }
  }


}