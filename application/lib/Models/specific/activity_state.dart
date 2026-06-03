import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';

class ActivityState {

  int selectedYear = 2026;

  double overallPercentage = 0;
  int totalAllWajibPajak = 0;

  int totalAllSudahBayar = 0;

  int totalAllRealisasiPbb = 0;
  int totalAllPbbTerhutang = 0;

  int jumlahSedangDidata2026 = 0;

  Map<String, int> totalSudahBayarMap = {};
  Map<String, int> totalWajibPajakMap = {};

  Map<String, int> totalPbbTerhutangMap  = {};
  Map<String, int> totalRealisasiPbbMap = {};

  Map<String, Map<String, int>> detailsCountMap = {};
  Map<String, double> percentageMap = {};

  List<ListKecamatanJson> kecamatan = [];
  List<ListKecamatanJson> filteredList = [];

  bool isLoading = false;
  bool isPercentageLoading = false;

  final searchController = TextEditingController();

  final List<int> availableYears = [
    2026, 
    2025,
    2024,
    2023,
  ];

}