import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:flutter/material.dart';


class OverdueState {

  final ScrollController scrollController = ScrollController();
  double offset = 0;

  int totalAllPbbTerhutang = 0;
  int totalAllWajibPajakTerhutang = 0;

  final searchController = TextEditingController();

  List<OverdueItem> allItems = [];
  List<OverdueItem> filteredItems = [];

  int? selectedYear = 2026;

  final List<int> availableYears = [
      2026, 
      2025,
      2024,
      2023,
    ];

  bool isLoading = false;


}