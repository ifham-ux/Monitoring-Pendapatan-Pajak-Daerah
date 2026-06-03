import '../Models/models.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class ApiService {

  //Fetch Router List Details

  static Future<List<ListDetailsRow>> fetchListDetails(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
    String kdKelurahan,
    int limit,
    int offset
  ) async {
    final response = await http.post(
      Uri.parse('https://backend-monitoring-pendapatan-pajak.vercel.app/objekPajak/listDetails'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "kdPropinsi": kdPropinsi,
          "kdDati2": kdDati2,
          "kdKecamatan": kdKecamatan,
          "kdKelurahan": kdKelurahan,
          "limit": limit,
          "offset": offset
        }
      }),
    );

    debugPrint('fetchListDetails status: ${response.statusCode}');
    debugPrint('fetchListDetails body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load data: ${response.statusCode}',
      );
    }
    try {
      final decoded = jsonDecode(response.body);
      final data = ListDetails.fromJson(decoded);

      return data.json.rows;

    } catch (e) {
      debugPrint('Parsing error: $e');
      rethrow;
    }
  }

  //Fetch Router Get By NOP

  static Future<GetByNop> fetchGetByNop(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
    String kdKelurahan,
    String kdBlok,
    String noUrut,
    String kdJnsOp
  ) async {
    final response = await http.post(
      Uri.parse('https://backend-monitoring-pendapatan-pajak.vercel.app/objekPajak/getByNop'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "kdPropinsi": kdPropinsi,
          "kdDati2": kdDati2,
          "kdKecamatan": kdKecamatan,
          "kdKelurahan": kdKelurahan,
          "kdBlok": kdBlok,
          "noUrut": noUrut,
          "kdJnsOp": kdJnsOp
        }
      }),
    );

    debugPrint('fetchGetByNop status: ${response.statusCode}');
    debugPrint('fetchGetByNop body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load data: ${response.statusCode}',
      );
    }
    try {
      final decoded = jsonDecode(response.body);
      final data = GetByNop.fromJson(decoded);

      return data;

    } catch (e) {
      debugPrint('Parsing error: $e');
      rethrow;
    }
  }

  //Fetch Router List Dati2

  static Future<List<ListDati2Json>> fetchListDati2(
    String kdPropinsi
  ) async {
    final response = await http.post(
      Uri.parse('https://backend-monitoring-pendapatan-pajak.vercel.app/wilayah/listDati2'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "kdPropinsi": kdPropinsi
        }
      }),
    );

    debugPrint('fetchListDati2 status: ${response.statusCode}');
    debugPrint('fetchListDati2 body: ${response.body}');

    try {
      final decoded = jsonDecode(response.body);
      final data = ListDati2.fromJson(decoded);

      return data.json;

    } catch (e) {
      debugPrint('Parsing error: $e');
      rethrow;
    }
  }

  //Fetch Router List Kecamatan

  static Future<List<ListKecamatanJson>> fetchListKecamatan(
    String kdPropinsi,
    String kdDati2
  ) async {
    final response = await http.post(
      Uri.parse('https://backend-monitoring-pendapatan-pajak.vercel.app/wilayah/listKecamatan'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "kdPropinsi": kdPropinsi,
          "kdDati2": kdDati2,
        }
      }),
    );

    debugPrint('fetchListKecamatan status: ${response.statusCode}');
    debugPrint('fetchListKecamatan body: ${response.body}');

    try {
      final decoded = jsonDecode(response.body);
      final data = ListKecamatan.fromJson(decoded);

      return data.json;

    } catch (e) {
      debugPrint('Parsing error: $e');
      rethrow;
    }
  }

  //Fetch Router List Kelurahan

  static Future<List<ListKelurahanJson>> fetchListKelurahan(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan
  ) async {
    final response = await http.post(
      Uri.parse('https://backend-monitoring-pendapatan-pajak.vercel.app/wilayah/listKelurahan'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "kdPropinsi": kdPropinsi,
          "kdDati2": kdDati2,
          "kdKecamatan": kdKecamatan,
        }
      }),
    );

    debugPrint('fetchListKelurahan status: ${response.statusCode}');
    debugPrint('fetchListKelurahan body: ${response.body}');

    try {
      final decoded = jsonDecode(response.body);
      final data = ListKelurahan.fromJson(decoded);

      return data.json;

    } catch (e) {
      debugPrint('Parsing error: $e');
      rethrow;
    }
  }

  //Fetch Router List Sppt

  static Future<List<ListSpptRow>> fetchListSppt(
    int thnPajak,
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
    String kdKelurahan,
    String statusPembayaran,
    int limit,
    int offset
  ) async {
    final response = await http.post(
      Uri.parse('https://backend-monitoring-pendapatan-pajak.vercel.app/sppt/list'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "thnPajak": thnPajak,
          "kdPropinsi": kdPropinsi,
          "kdDati2": kdDati2,
          "kdKecamatan": kdKecamatan,
          "kdKelurahan": kdKelurahan,
          "statusPembayaran": statusPembayaran,
          "limit": limit,
          "offset": offset
        }
      }),
    );

    debugPrint('fetchListSppt status: ${response.statusCode}');
    debugPrint('fetchListSppt body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load data: ${response.statusCode}',
      );
    }
    try {
      final decoded = jsonDecode(response.body);
      final data = ListSppt.fromJson(decoded);

      return data.json.rows;

    } catch (e) {
      debugPrint('Parsing error: $e');
      rethrow;
    }
  }

  //Fetch Router Get Sppt History

  static Future<List<GetSpptHistoryJson>> fetchGetSpptHistory(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
    String kdKelurahan,
    String kdBlok,
    String noUrut,
    String kdJnsOp
  ) async {
    final response = await http.post(
      Uri.parse('https://backend-monitoring-pendapatan-pajak.vercel.app/objekPajak/getSpptHistory'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "kdPropinsi": kdPropinsi,
          "kdDati2": kdDati2,
          "kdKecamatan": kdKecamatan,
          "kdKelurahan": kdKelurahan,
          "kdBlok": kdBlok,
          "noUrut": noUrut,
          "kdJnsOp": kdJnsOp,
        }
      }),
    );

    debugPrint('GetSpptHistory status: ${response.statusCode}');
    debugPrint('GetSpptHistory body: ${response.body}');

    try {
      final decoded = jsonDecode(response.body);
      final data = GetSpptHistory.fromJson(decoded);

      return data.json;

    } catch (e) {
      debugPrint('Parsing error: $e');
      rethrow;
    }
  }

  //Fetch Router Get Tahun Sppt

  static Future<GetTahunSpptJson> fetchGetTahunSppt(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
    String kdKelurahan,
    String kdBlok,
    String noUrut,
    String kdJnsOp,
    String thnPajakSppt
  ) async {
    final response = await http.post(
      Uri.parse('https://backend-monitoring-pendapatan-pajak.vercel.app/sppt/get'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "kdPropinsi": kdPropinsi,
          "kdDati2": kdDati2,
          "kdKecamatan": kdKecamatan,
          "kdKelurahan": kdKelurahan,
          "kdBlok": kdBlok,
          "noUrut": noUrut,
          "kdJnsOp": kdJnsOp,
          "thnPajakSppt": thnPajakSppt
        }
      }),
    );

    debugPrint('GetTahunSppt status: ${response.statusCode}');
    debugPrint('GetTahunSppt body: ${response.body}');

    try {
      final decoded = jsonDecode(response.body);
      final data = GetTahunSppt.fromJson(decoded);

      return data.json;

    } catch (e) {
      debugPrint('Parsing error: $e');
      rethrow;
    }
  }

}