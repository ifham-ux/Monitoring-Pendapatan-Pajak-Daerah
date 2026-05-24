import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/Models/getsppthistory.dart';
import 'package:testing/Models/gettahunsppt.dart';
import 'package:testing/Models/listkelurahan.dart';
import 'package:testing/Models/listsppt.dart';
import 'package:testing/Models/listdetails.dart';
import 'package:testing/Models/getbynop.dart';

import '../Models/listkecamatan.dart';

class ApiService {
  static Future<List<listkecamatan>> fetchKecamatan(
    String kdPropinsi,
    String kdDati2,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/wilayah/listKecamatan'),
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

    debugPrint('fetchKecamatan status: ${response.statusCode}');
    debugPrint('fetchKecamatan body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load data: ${response.statusCode}. Body: ${response.body}');
    }

    final decoded = jsonDecode(response.body);

    List<dynamic>? rows;

    if (decoded is Map<String, dynamic>) {
      // Common patterns:
      // 1) { "json": { "data": [ ... ] } }
      final jsonObj = decoded['json'];
      if (jsonObj is Map<String, dynamic> && jsonObj['data'] is List) {
        rows = jsonObj['data'] as List;
      }

      // 2) { "json": [ ... ] }
      if (rows == null && jsonObj is List) {
        rows = jsonObj;
      }

      // 3) { "result": [ ... ] }
      final resultObj = decoded['result'];
      if (rows == null && resultObj is List) {
        rows = resultObj;
      }

      // 4) { "data": [ ... ] }
      final dataObj = decoded['data'];
      if (rows == null && dataObj is List) {
        rows = dataObj;
      }
    }

    // If no rows found, fail loudly instead of returning empty list.
    if (rows == null) {
      throw Exception(
        'Unexpected response format. Expected an array list but could not find it. '
        'Top-level keys: ${decoded is Map<String, dynamic> ? decoded.keys.toList() : decoded.runtimeType}. '
        'Full body: ${response.body}',
      );
    }

    // Ensure items are maps before parsing.
    final list = rows
        .whereType<Map<String, dynamic>>()
        .map((item) => listkecamatan.fromJson(item))
        .toList();

    return list;
  }
  

  static Future<List<listkelurahan>> fetchKelurahan(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/wilayah/listKelurahan'),
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

    debugPrint('fetchKelurahan status: ${response.statusCode}');
    debugPrint('fetchKelurahan body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load data: ${response.statusCode}. Body: ${response.body}');
    }

    final decoded = jsonDecode(response.body);

    List<dynamic>? rows;

    if (decoded is Map<String, dynamic>) {
      // Common patterns:
      // 1) { "json": { "data": [ ... ] } }
      final jsonObj = decoded['json'];
      if (jsonObj is Map<String, dynamic> && jsonObj['data'] is List) {
        rows = jsonObj['data'] as List;
      }

      // 2) { "json": [ ... ] }
      if (rows == null && jsonObj is List) {
        rows = jsonObj;
      }

      // 3) { "result": [ ... ] }
      final resultObj = decoded['result'];
      if (rows == null && resultObj is List) {
        rows = resultObj;
      }

      // 4) { "data": [ ... ] }
      final dataObj = decoded['data'];
      if (rows == null && dataObj is List) {
        rows = dataObj;
      }
    }

    // If no rows found, fail loudly instead of returning empty list.
    if (rows == null) {
      throw Exception(
        'Unexpected response format. Expected an array list but could not find it. '
        'Top-level keys: ${decoded is Map<String, dynamic> ? decoded.keys.toList() : decoded.runtimeType}. '
        'Full body: ${response.body}',
      );
    }

    // Ensure items are maps before parsing.
    final list = rows
        .whereType<Map<String, dynamic>>()
        .map((item) => listkelurahan.fromJson(item))
        .toList();

    return list;
  }


  static Future<List<listsppt>> fetchListSppt(
    int thnPajak,
    String kdPropinsi,
    String kdDati2,
    String? kdKecamatan,
    String? kdKelurahan,
    String? statusPembayaran,
    int limit,
    int offset
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/sppt/list'),
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

    final decoded = jsonDecode(response.body);

    List<dynamic>? rows;

    if (decoded is Map<String, dynamic>) {
      final jsonObj = decoded['json'];

      if (jsonObj is Map<String, dynamic> &&
          jsonObj['rows'] is List) {
        rows = jsonObj['rows'] as List;
      }

      if (rows == null && jsonObj is List) {
        rows = jsonObj;
      }

      final resultObj = decoded['result'];
      if (rows == null && resultObj is List) {
        rows = resultObj;
      }

      final dataObj = decoded['data'];
      if (rows == null && dataObj is List) {
        rows = dataObj;
      }
    }

    if (rows == null) {
      throw Exception('Unexpected response format');
    }

    final list = rows
        .whereType<Map<String, dynamic>>()
        .map((item) => listsppt.fromJson(item))
        .toList();

    return list;
  }


  static Future<gettahunsppt> fetchGetTahunSppt(
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
      Uri.parse('http://localhost:8080/sppt/get'),
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
          "thnPajakSppt": thnPajakSppt,
        }
      }),
    );

    debugPrint('fetchGetTahunSppt status: ${response.statusCode}');
    debugPrint('fetchGetTahunSppt body: ${response.body}');

    if (response.statusCode != 200) {
    throw Exception(
      'Failed to load data: ${response.statusCode}',
    );
  }

  final decoded = jsonDecode(response.body);

  final jsonObj = decoded['json'];

  if (jsonObj == null || jsonObj is! Map<String, dynamic>) {
    throw Exception('Unexpected response format');
  }

  return gettahunsppt.fromJson(jsonObj);

  }

  static Future<List<getsppthistory>> fetchGetSpptHistory(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
    String kdKelurahan,
    String kdBlok,
    String noUrut,
    String kdJnsOp,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/objekPajak/getHistory'),
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

    debugPrint('fetchGetSpptHistory status: ${response.statusCode}');
    debugPrint('fetchGetSpptHistory body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load data: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body);

    List<dynamic>? rows;

    if (decoded is Map<String, dynamic>) {
      final jsonObj = decoded['json'];

      if (jsonObj is Map<String, dynamic> &&
          jsonObj['rows'] is List) {
        rows = jsonObj['rows'] as List;
      }

      if (rows == null && jsonObj is List) {
        rows = jsonObj;
      }

      final resultObj = decoded['result'];
      if (rows == null && resultObj is List) {
        rows = resultObj;
      }

      final dataObj = decoded['data'];
      if (rows == null && dataObj is List) {
        rows = dataObj;
      }
    }

    if (rows == null) {
      throw Exception('Unexpected response format');
    }

    final list = rows
        .whereType<Map<String, dynamic>>()
        .map((item) => getsppthistory.fromJson(item))
        .toList();

    return list;
  }

  static Future<List<listdetails>> fetchListDetails(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
    String kdKelurahan,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/objekPajak/listDetails'),
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "json": {
          "kdPropinsi": kdPropinsi,
          "kdDati2": kdDati2,
          "kdKecamatan": kdKecamatan,
          "kdKelurahan": kdKelurahan,
        }
      }),
    );

    debugPrint('fetchGetListDetails status: ${response.statusCode}');
    debugPrint('fetchGetListDetails body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load data: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body);

    List<dynamic>? rows;

    if (decoded is Map<String, dynamic>) {
      final jsonObj = decoded['json'];

      if (jsonObj is Map<String, dynamic> &&
          jsonObj['rows'] is List) {
        rows = jsonObj['rows'] as List;
      }

      if (rows == null && jsonObj is List) {
        rows = jsonObj;
      }

      final resultObj = decoded['result'];
      if (rows == null && resultObj is List) {
        rows = resultObj;
      }

      final dataObj = decoded['data'];
      if (rows == null && dataObj is List) {
        rows = dataObj;
      }
    }

    if (rows == null) {
      throw Exception('Unexpected response format');
    }

    final list = rows
        .whereType<Map<String, dynamic>>()
        .map((item) => listdetails.fromJson(item))
        .toList();

    return list;
  }

  // FIX #1: Corrected return type to List<getbynop>
  static Future<List<getbynop>> fetchGetByNop(
    String kdPropinsi,
    String kdDati2,
    String kdKecamatan,
    String kdKelurahan,
    String kdBlok,
    String noUrut,
    String kdJnsOp,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/objekPajak/getByNop'),
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

    debugPrint('fetchGetByNop status: ${response.statusCode}');
    debugPrint('fetchGetByNop body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load data: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body);

    List<dynamic>? rows;

    if (decoded is Map<String, dynamic>) {
      final jsonObj = decoded['json'];

      if (jsonObj is Map<String, dynamic> &&
          jsonObj['rows'] is List) {
        rows = jsonObj['rows'] as List;
      }

      if (rows == null && jsonObj is List) {
        rows = jsonObj;
      }

      final resultObj = decoded['result'];
      if (rows == null && resultObj is List) {
        rows = resultObj;
      }

      final dataObj = decoded['data'];
      if (rows == null && dataObj is List) {
        rows = dataObj;
      }
    }

    if (rows == null) {
      throw Exception('Unexpected response format');
    }

    // FIX #1: Return list instead of single object
    final list = rows
        .whereType<Map<String, dynamic>>()
        .map((item) => getbynop.fromJson(item))
        .toList();

    return list;
  }
}