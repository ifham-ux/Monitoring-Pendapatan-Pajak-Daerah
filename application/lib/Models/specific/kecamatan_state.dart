import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';

class KecamatanState {
  bool isLoading = false;
  bool isPercentageLoading = false;

  double overallPercentage = 0;
  int totalAllWajibPajak = 0;

  int totalAllSudahBayar = 0;

  int totalAllRealisasiPbb = 0;
  int totalAllPbbTerhutang = 0;

  int selectedYear = 2026;

  Map<String, List<ListDetailsRow>> detailsMap = {};

  List<ListKelurahanJson> kelurahan = [];
  List<ListKelurahanJson> filteredList = [];

  Map<String, int> totalSudahBayarMap = {};
  Map<String, int> totalWajibPajakMap = {};
  Map<String, int> totalPbbTerhutangMap = {};
  Map<String, int> totalRealisasiPbbMap = {};
  Map<String, double> percentageMap = {};

  final searchController = TextEditingController();

  final List<int> availableYears = [
    2026, 
    2025,
    2024,
    2023,
  ];

}