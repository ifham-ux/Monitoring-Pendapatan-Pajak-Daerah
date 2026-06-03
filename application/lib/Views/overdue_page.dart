import 'package:flutter/material.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Widgets/widgets.dart';

import 'details_page.dart';

class OverduePage extends StatefulWidget {
  const OverduePage({super.key});

  @override
  State<OverduePage> createState() => _OverduePageState();
}

class _OverduePageState extends State<OverduePage> {
  final state = OverdueState();

  Future<void> loadOverdue() async {
    setState(() {
      state.isLoading = true;
    });

    try {
      final result = await OverdueService.fetchOverdue(
        state.selectedYear ?? 0,
      );

      if (!mounted) return;

      setState(() {
        state.allItems = result;
        state.totalAllWajibPajakTerhutang = result.length;
        state.totalAllPbbTerhutang = result.fold(
          0,
          (sum, item) => sum + item.sppt.pbbTerhutangSppt,
        );
      });

      applyFilters();
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

  void applyFilters() {
    final filtered = Search.filterList<OverdueItem>(
      items: state.allItems,
      query: state.searchController.text,
      selector: (item) => [
        item.sppt.nmWpSppt,
        '${item.sppt.kdPropinsi}.'
        '${item.sppt.kdDati2}.'
        '${item.sppt.kdKecamatan}.'
        '${item.sppt.kdKelurahan}.'
        '${item.sppt.kdBlok}.'
        '${item.sppt.noUrut}.'
        '${item.sppt.kdJnsOp}',
        item.sppt.kdPropinsi,
        item.sppt.kdDati2,
        item.sppt.kdKecamatan,
        item.sppt.kdKelurahan,
        item.sppt.kdBlok,
        item.sppt.noUrut,
        item.sppt.kdJnsOp,
      ],
    );

    setState(() {
      state.filteredItems = filtered;
    });
  }

  @override
  void initState() {
    super.initState();
    state.searchController.addListener((applyFilters));
    loadOverdue();
  }

  @override
  void dispose() {
    state.searchController.removeListener(applyFilters);
    state.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackOne,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                width: double.infinity,
                height: 275,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        state.totalAllPbbTerhutang > 0 
                        ? 'assets/iconImage/overdue.png'
                        : 'assets/iconImage/finished.png',
                        fit: BoxFit.cover, 
                      ),
                    ),

                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Terhutang',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'PlusJakartaSans',
                              color: AppColors.whiteThree
                            )
                          ),

                          Text(
                            formatCurrency(state.totalAllPbbTerhutang),
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'PlusJakartaSans',
                              color: AppColors.whiteOne
                            )
                          ),

                          Text(
                            'dari  ${state.totalAllWajibPajakTerhutang}  Wajib Pajak',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'PlusJakartaSans',
                              color: AppColors.whiteOne
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    SearchBox(
                      controller: state.searchController,
                      hintText: 'Search Wajib Pajak',
                      onFilterTap: () {
                        yearFilterDialog(
                          context: context,
                          selectedYear: state.selectedYear ?? 0,
                          years: state.availableYears,
                          allowAllYears: true,
                          onSelected: (year) async {
                            setState(() {
                              state.selectedYear = year;
                            });
                            await loadOverdue();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    if (state.isLoading)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        itemBuilder: (_, __) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: OverviewCardShimmer(),
                        ),
                      )
                    
                    else if (state.filteredItems.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'Data tidak ditemukan.',
                            style: TextStyle(
                              color: AppColors.whiteThree,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = state.filteredItems[index];
                        final sppt = item.sppt;


                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: OverviewVersion2Card(
                            tahun: sppt.thnPajakSppt,
                            nop:
                                '${sppt.kdPropinsi}.${sppt.kdDati2}.${sppt.kdKecamatan}.${sppt.kdKelurahan}.${sppt.kdBlok}.${sppt.noUrut}.${sppt.kdJnsOp}',
                            nmWpSppt: sppt.nmWpSppt,
                            status: sppt.statusPembayaranSppt == 1
                                    ? 'Lunas'
                                    : 'Belum Lunas',
                            statusGradient: sppt.statusPembayaranSppt == 1
                                    ? AppGradient.yesyes
                                    : AppGradient.nono,
                            terhutang: formatCurrency(sppt.pbbYgHarusDibayarSppt),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 200),

                                  pageBuilder: (_, animation, __) => DetailsPage(
                                    kdPropinsi: sppt.kdPropinsi,
                                    kdDati2: sppt.kdDati2,
                                    kdKecamatan: sppt.kdKecamatan,
                                    kdKelurahan: sppt.kdKelurahan,
                                    kdBlok: sppt.kdBlok,
                                    noUrut: sppt.noUrut,
                                    kdJnsOp: sppt.kdJnsOp,
                                    selectedYear: int.parse(sppt.thnPajakSppt),
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
                          )
                        );
                      },
                    ),
                    const SizedBox(height: 115),
                  ],
                ),
              ),

            ],
          ),  
          
        ),
      ),
    );
  }
}

