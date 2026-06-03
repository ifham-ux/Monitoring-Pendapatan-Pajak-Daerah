import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';

class KelurahanState {
  bool isLoading = false;

  int selectedYear = 2026;

  List<ListDetailsRow> detailsList = [];
  List<ListDetailsRow> filteredDetailsList = [];
  
  List<ListSpptRow> spptList = [];
  List<ListSpptRow> filteredSpptList = [];
  
  final searchController = TextEditingController();

  int pbbTerhutang = 0;
  int realisasiPbb = 0;

  int totalObjek = 0;

  int sedangDidata = 0;
  int sedangDiperiksa = 0;
  int totalSudahBayar = 0;

  double percentage = 0.0;

  final List<int> availableYears = [
    2026, 
    2025,
    2024,
    2023,
  ];

}