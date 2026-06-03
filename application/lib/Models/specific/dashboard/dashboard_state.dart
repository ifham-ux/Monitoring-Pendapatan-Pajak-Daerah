import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';

class DashboardState {

  List<ListKecamatanJson> kecamatan = [];

  Map<String, int> totalSudahBayarMap = {};
  Map<String, int> totalWajibPajakMap = {};
  Map<String, double> percentageMap = {};

  bool isKecamatanLoading = false;

  int selectedYear = DateTime.now().year;

  bool isLoading = false;

  int totalWajibPajak = 0;
  int totalSudahBayar = 0;

  int totalTarget = 0;
  int totalRealisasi = 0;

  double percentage = 0;

  List<DashboardChartData> chartData = [];

  final List<int> years = [
    2026,
    2025,
    2024,
    2023,
  ];
}