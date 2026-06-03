import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'detail_item.dart';

class NopDetailState{
  bool isLoading = false;
  int selectedYear = 2026;
  DetailItem? details;

  GetByNopJson? biodata;

  final List<int> availableYears = [
    2026, 
    2025,
    2024,
    2023,
  ];
}