import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/specific/activity_service.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Widgets/widgets.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';

import 'kecamatan_page.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {

  final state = ActivityState();

  @override
  void initState() {
    super.initState();
    loadKecamatan();
    state.searchController.addListener(() {
      searchKecamatan(state.searchController.text);
    });
  }

  @override
  void dispose() {
    state.searchController.dispose();
    super.dispose();
  }


  Future<void> loadKecamatan() async {

    setState(() {
      state.isLoading = true;
    });

    try {
      final result = await ActivityService.loadKecamatan();

      state.kecamatan = result;
      state.filteredList = result;

      await loadDetailsCounts();
      await loadPercentageData();

    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          state.isLoading = false;
        });
      }
    }
  }

  void searchKecamatan(String query) {
    setState(() {
      state.filteredList = Search.filterList(
        items: state.kecamatan,
        query: query,

        selector: (item) => [
          item.nmKecamatan,
        ],
      );
    });
  }

  Future<void> loadDetailsCounts() async {
    final result = await ActivityService.loadDetailsCounts(state.kecamatan);

    if (!mounted) return;
    setState(() {
      state.detailsCountMap = result["detailsCountMap"];
      state.jumlahSedangDidata2026 = result["jumlahSedangDidata2026"];
    });
  }


  Future<void> loadPercentageData() async {
    setState(() {
      state.isPercentageLoading = true;
    });

    try {
      final result = await ActivityService.loadPercentageData(
        selectedYear: state.selectedYear,
        kecamatan: state.kecamatan,
      );

      if (!mounted) return;

      setState(() {

        state.percentageMap = result["percentageMap"];
        state.totalSudahBayarMap = result["totalSudahBayarMap"];
        state.totalWajibPajakMap = result["totalWajibPajakMap"];
        state.totalPbbTerhutangMap = result["totalPbbTerhutangMap"];
        state.totalRealisasiPbbMap = result["totalRealisasiPbbMap"];
        state.totalAllWajibPajak = result["totalAllWajibPajak"];
        state.totalAllSudahBayar = result["totalAllSudahBayar"];
        state.overallPercentage = result["overallPercentage"];
        state.totalAllPbbTerhutang = result["totalAllPbbTerhutang"];
        state.totalAllRealisasiPbb = result["totalAllRealisasiPbb"];
      });

    } finally {

      if (mounted) {

        setState(() {
          state.isPercentageLoading = false;
        });
      }
    }
  }

  Future<void> openFilterModal() async {
    await yearFilterDialog(
      context: context,
      selectedYear: state.selectedYear,
      years: state.availableYears,

      onSelected: (year) async {

        if (year == null) return;
        setState(() {
          state.selectedYear = year;
        });

        await loadPercentageData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: state.isLoading
          ? const ActivityPageShimmer()
          : SingleChildScrollView(
          child: Column(
            children: [

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: MainSummaryCard(
                overallPercentage: state.overallPercentage,
                totalSudahBayar: state.totalAllSudahBayar,
                totalWajibPajak: state.totalAllWajibPajak,
                totalRealisasiPbb: state.totalAllRealisasiPbb,
                totalPbbTerhutang: state.totalAllPbbTerhutang,
                isCurrentYear: state.selectedYear,
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Total Kecamatan',
                      value: state.kecamatan.length.toString(),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: StatCard(
                      title: 'Sedang didata',
                      value: state.selectedYear == 2026 ?
                      state.jumlahSedangDidata2026.toString()
                      : "0",
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: StatCard(
                      title: 'Sedang diperiksa',
                      value: '0',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: SearchBox(
                controller: state.searchController,
                hintText: 'Search Kecamatan',
                onFilterTap: openFilterModal,
              ),
            ),

            const SizedBox(height: 23),
            
            if (state.isLoading)

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),

                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              )

            else if (state.filteredList.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  'No Kecamatan Found',
                  style: TextStyle(
                    color: AppColors.whiteOne,
                  ),
                ),
              )

            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: state.filteredList.length,
                itemBuilder: (context, index) {
                  final item = state.filteredList[index];

                  final sudahBayar = state.totalSudahBayarMap[item.kdKecamatan] ?? 0;
                  final wajibPajak = state.totalWajibPajakMap[item.kdKecamatan] ?? 0;
                  final terhutang = state.totalPbbTerhutangMap[item.kdKecamatan] ?? 0;
                  final realisasi = state.totalRealisasiPbbMap[item.kdKecamatan] ?? 0;
                  final detailData = state.detailsCountMap[item.kdKecamatan];
                  final totalWajibPajak = detailData?["wajibPajak"] ?? 0;
                  final totalKelurahan = detailData?["kelurahan"] ?? 0;

                  return OverviewCard(
                    isCurrentYear: state.selectedYear,
                    isPercentageLoading: state.isPercentageLoading,
                    title: item.nmKecamatan
                    ,
                    percentage: state.percentageMap[item.kdKecamatan] ?? 0.0,
                    code: 'Kode: ${item.kdPropinsi}.${item.kdDati2}.${item.kdKecamatan}',
                    sudahBayar: sudahBayar,
                    wajibPajak: wajibPajak,
                    terhutang: terhutang,
                    realisasi: realisasi,

                    bottomChildren: [
                      Text(
                        '$totalWajibPajak Wajib Pajak',
                        style: const TextStyle(
                          color: AppColors.whiteOne,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),

                      Text(
                        '$totalKelurahan Kelurahan',
                        style: const TextStyle(
                          color: AppColors.whiteOne,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],

                    onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 200),

                        pageBuilder: (_, animation, __) => KecamatanPage(
                          kdPropinsi: "51",
                          kdDati2: "71",
                          kdKecamatan: item.kdKecamatan,
                          nmKecamatan: item.nmKecamatan,

                          totalKelurahan: totalKelurahan,
                          percentage: state.percentageMap[item.kdKecamatan] ?? 0.0,
                          totalWajibPajak: totalWajibPajak,

                          selectedYear: state.selectedYear,
                        ),

                        transitionsBuilder: (_, animation, __, child) {
                          final curve = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          );

                          return FadeTransition(
                            opacity: curve,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(curve),
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  );
                },
              ),
            SizedBox(height: 60),
          ],
        ),
      ),
      ),
    );
  }
}