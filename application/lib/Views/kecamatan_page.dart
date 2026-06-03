import 'package:flutter/material.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'kelurahan_page.dart';
import 'calculator_page.dart';

class KecamatanPage extends StatefulWidget {
  final String kdPropinsi;
  final String kdDati2;
  final String kdKecamatan;
  final String nmKecamatan;

  final int totalKelurahan;
  final double percentage;
  final int totalWajibPajak;

  final int selectedYear;

  const KecamatanPage({
    super.key,
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.nmKecamatan,
    required this.totalKelurahan,
    required this.percentage,
    required this.totalWajibPajak,
    required this.selectedYear,
  });

  @override
  State<KecamatanPage> createState() => _KecamatanPageState();
}

class _KecamatanPageState extends State<KecamatanPage> {
  final state = KecamatanState();

  @override
  void initState() {
    super.initState();

    state.selectedYear = widget.selectedYear;

    loadKelurahan();

    state.searchController.addListener(() {
      searchKelurahan(state.searchController.text);
    });
  }

  @override
  void dispose() {
    state.searchController.dispose();
    super.dispose();
  }

  void searchKelurahan(String query) {
    setState(() {
      state.filteredList = Search.filterList(
        items: state.kelurahan,
        query: query,
        selector: (item) => [
          item.nmKelurahan
        ],
      );
    });
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

  Future<void> loadKelurahan() async {
    setState(() {
      state.isLoading = true;
    });

    try {
      final result = await KecamatanService.loadKelurahan(widget.kdKecamatan);
      state.kelurahan = result;
      searchKelurahan(
        state.searchController.text,
      );

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

  Future<void> loadPercentageData() async {
    setState(() {
      state.isPercentageLoading = true;
    });

    try {
      final result = await KecamatanService.loadPercentageData(
        selectedYear: state.selectedYear,
        kdKecamatan: widget.kdKecamatan,
        kelurahan: state.kelurahan,
      );

      final totalSudahBayarMap =
          Map<String, int>.from(result["totalSudahBayarMap"] ?? {});

      final totalWajibPajakMap =
          Map<String, int>.from(result["totalWajibPajakMap"] ?? {});

      final totalPbbTerhutangMap =
          Map<String, int>.from(result["totalPbbTerhutangMap"] ?? {});

      final totalRealisasiPbbMap =
          Map<String, int>.from(result["totalRealisasiPbbMap"] ?? {});

      int totalWajibPajak = 0;
      int totalSudahBayar = 0;
      int totalTerhutang = 0;
      int totalRealisasi = 0;

      for (final value in totalWajibPajakMap.values) {
        totalWajibPajak += value;
      }

      for (final value in totalSudahBayarMap.values) {
        totalSudahBayar += value;
      }

      for (final value in totalPbbTerhutangMap.values) {
        totalTerhutang += value;
      }

      for (final value in totalRealisasiPbbMap.values) {
        totalRealisasi += value;
      }

      double percentage = 0;

      if (totalWajibPajak > 0) {
        percentage = (totalSudahBayar / totalWajibPajak) * 100;
      }

      if (!mounted) return;
      setState(() {
        state.percentageMap =
            Map<String, double>.from(result["tempPercentage"] ?? {});

        state.totalSudahBayarMap = totalSudahBayarMap;
        state.totalWajibPajakMap = totalWajibPajakMap;
        state.totalPbbTerhutangMap = totalPbbTerhutangMap;
        state.totalRealisasiPbbMap = totalRealisasiPbbMap;

        state.detailsMap =
            Map<String, List<ListDetailsRow>>.from(
              result["detailsMap"] ?? {},
            );

        state.totalAllWajibPajak = totalWajibPajak;
        state.totalAllSudahBayar = totalSudahBayar;

        state.totalAllPbbTerhutang = totalTerhutang;
        state.totalAllRealisasiPbb = totalRealisasi;

        state.overallPercentage = percentage;
      
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          state.isPercentageLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: AppColors.blackOne,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.whiteOne),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.whiteOne,
            boxShadow: [
              BoxShadow(
                color: AppColors.blackThree,
                blurRadius: 12,
                offset: Offset(0, 6)
              ),
            ],
          ),

          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => CalculatorPage(),
                ),
              );
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
            child: SvgPicture.asset(
              'assets/iconImage/calculator.svg',
              width: 19,
              height: 22,
              colorFilter: ColorFilter.mode(
                AppColors.blackOne,
                BlendMode.srcIn,
              ),
            ),
            
          ),
        ),
      ),

      body: SafeArea(
        child: state.isLoading
          ? const SingleChildScrollView(
              child: PaginationShimmer(),
            )
          : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kecamatan',
                      style: TextStyle(
                        color: AppColors.whiteOne,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 26,
                      ),
                    ),

                    Text(
                      widget.nmKecamatan,
                      style: TextStyle(
                        color: AppColors.whiteOne,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 32,
                      ),
                    ),

                    Text(
                      'Kode: ${widget.kdPropinsi}.${widget.kdDati2}.${widget.kdKecamatan}',
                      style: TextStyle(
                        color: AppColors.whiteThree,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      StatCard(
                        title: 'Persentase Sudah Bayar terhadap total Wajib Pajak',
                        value: '${state.overallPercentage.toStringAsFixed(1)} %',
                        gradient: getPercentageGradient(state.overallPercentage),
                        titleColor: AppColors.blackThree,
                        titleSize: 10,
                        valueColor: AppColors.blackOne,
                        boxShadow: getStatCardShadow(state.overallPercentage),
                        width: 115,
                        height: 135,
                        valueSize: 21,
                      ),

                      const SizedBox(width: 15),

                      StatCard(
                        title: 'Perbandingan Sudah Bayar terhadap total Wajib Pajak',
                        value: '${state.totalAllSudahBayar} / ${state.totalAllWajibPajak}',
                        titleSize: 10,
                        valueSize: 25,
                        width: 115,
                        height: 135,
                      ),

                      const SizedBox(width: 15),

                      StatCard(
                        title: 'Total Kelurahan',
                        value: widget.totalKelurahan.toString(),
                        width: 115,
                        height: 135,
                      ),

                      const SizedBox(width: 15),

                      StatCard(
                        title: 'Sedang didata',
                        value: state.selectedYear == 2026 ?
                        state.totalAllWajibPajak.toString() : "0",
                        width: 115,
                        height: 135,
                      ),

                      const SizedBox(width: 15),
                      
                      StatCard(
                        title: 'Sedang diperiksa',
                        value: '0',
                        width: 115,
                        height: 135,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBox(
                  controller: state.searchController,
                  hintText: 'Search Kelurahan',
                  onFilterTap: openFilterModal, 
                ),
              ),

              const SizedBox(height: 23),
              
              if (state.filteredList.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    'No Kelurahan Found',
                    style: TextStyle(color: AppColors.whiteOne),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.filteredList.length,
                  itemBuilder: (context, index) {
                    final item = state.filteredList[index];

                    final wajibPajak = state.totalWajibPajakMap[item.kdKelurahan] ?? 0;
                    final sudahBayar = state.totalSudahBayarMap[item.kdKelurahan] ?? 0;
                    final terhutang = state.totalPbbTerhutangMap[item.kdKelurahan] ?? 0;
                    final realisasi = state.totalRealisasiPbbMap[item.kdKelurahan] ?? 0;
                    final percentage = state.percentageMap[item.kdKelurahan] ?? 0.0;

                    return OverviewCard(
                      isCurrentYear: state.selectedYear,
                      isPercentageLoading: state.isPercentageLoading,
                      title: item.nmKelurahan,
                      percentage: percentage,
                      code: 'Kode: ${item.kdPropinsi}.${item.kdDati2}.${item.kdKecamatan}.${item.kdKelurahan}',
                      wajibPajak: wajibPajak,
                      sudahBayar: sudahBayar,
                      terhutang: terhutang,
                      realisasi: realisasi,
                      bottomChildren: [
                        Text(
                          '$wajibPajak Wajib Pajak',
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
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                KelurahanPage(
                                  kdPropinsi: widget.kdPropinsi,
                                  kdDati2: widget.kdDati2,
                                  kdKecamatan: widget.kdKecamatan,
                                  kdKelurahan: item.kdKelurahan,
                                  nmKelurahan: item.nmKelurahan,
                                  selectedYear: state.selectedYear,
                                ),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOutCubic;

                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 300),
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

