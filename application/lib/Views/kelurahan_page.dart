import 'package:flutter/material.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'details_page.dart';
import 'calculator_page.dart';

class KelurahanPage extends StatefulWidget {

  final String kdPropinsi;
  final String kdDati2;
  final String kdKecamatan;
  final String kdKelurahan;
  final String nmKelurahan;
  final int selectedYear;

  const KelurahanPage({
    super.key,
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.nmKelurahan,
    required this.selectedYear,
  });

  @override
  State<KelurahanPage> createState() =>
      _KelurahanPageState();
}

class _KelurahanPageState extends State<KelurahanPage> {
  final state = KelurahanState();


  @override
  void initState() {
    super.initState();
    state.selectedYear = widget.selectedYear;
      state.searchController.addListener(() {
      searchNop(state.searchController.text);
    });
    loadData();
  }

  void searchNop(String query) {
    final q = query.toLowerCase().trim();

    setState(() {
      if (state.selectedYear == 2026) {

        if (q == 'sedang didata') {
          state.filteredDetailsList = state.detailsList;
          return;
        }

        state.filteredDetailsList = Search.filterList(
          items: state.detailsList,
          query: query,
          selector: (item) => [
            item.nmWpSppt,

            '${item.kdPropinsi}'
            '${item.kdDati2}'
            '${item.kdKecamatan}'
            '${item.kdKelurahan}'
            '${item.kdBlok}'
            '${item.noUrut}'
            '${item.kdJnsOp}',
          ],
        );
      } else {

        if (q == 'lunas') {
          state.filteredSpptList = state.spptList
              .where((e) => e.statusPembayaranSppt == 1)
              .toList();
          return;
        }

        if (q == 'belum lunas') {
          state.filteredSpptList = state.spptList
              .where((e) => e.statusPembayaranSppt != 1)
              .toList();
          return;
        }

        state.filteredSpptList = Search.filterList(
          items: state.spptList,
          query: query,
          selector: (item) => [
            item.nmWpSppt,

            '${item.kdPropinsi}'
            '${item.kdDati2}'
            '${item.kdKecamatan}'
            '${item.kdKelurahan}'
            '${item.kdBlok}'
            '${item.noUrut}'
            '${item.kdJnsOp}',
          ],
        );
      }
    });
  }

  Future<void> loadData() async {
    setState(() {
      state.isLoading = true;
    });

    try {
      final result = await KelurahanService.loadData(
        selectedYear: state.selectedYear,
        kdPropinsi: widget.kdPropinsi,
        kdDati2: widget.kdDati2,
        kdKecamatan: widget.kdKecamatan,
        kdKelurahan: widget.kdKelurahan
      );

      if (!mounted) return;

      int totalObjek = 0;
      int sedangDidata = 0;
      int sedangDiperiksa = 0;

      int totalSudahBayar = 0;
      int totalTerhutang = 0;
      int totalRealisasi = 0;

      if (result['isDetails'] == true) {

        final details =
            List<ListDetailsRow>.from(result['detailsList'] ?? []);

        totalObjek = details.length;
        sedangDidata = details.length;

        setState(() {
          state.detailsList = details;
          state.filteredDetailsList = details;

          state.spptList = [];
          state.filteredSpptList = [];

          state.totalObjek = totalObjek;
          state.sedangDidata = sedangDidata;
          state.sedangDiperiksa = sedangDiperiksa;

          state.totalSudahBayar = 0;
          state.pbbTerhutang = 0;
          state.realisasiPbb = 0;
          state.percentage = 0;
        });

      } else {

        final sppt =
            List<ListSpptRow>.from(result['spptList'] ?? []);

        totalObjek = sppt.length;

        for (final item in sppt) {

          totalTerhutang += item.pbbTerhutangSppt;

          if (item.statusPembayaranSppt == 1) {
            totalSudahBayar++;
            totalRealisasi += item.pbbTerhutangSppt;
          }
        }

        final percentage =
            totalObjek > 0
                ? (totalSudahBayar / totalObjek) * 100
                : 0.0;

        setState(() {

          state.detailsList = [];
          state.filteredDetailsList = [];
          state.spptList = sppt;
          state.filteredSpptList = sppt;
          state.totalObjek = totalObjek;
          state.totalSudahBayar = totalSudahBayar;
          state.pbbTerhutang = totalTerhutang;
          state.realisasiPbb = totalRealisasi;
          state.percentage = percentage;
        });
      }
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

  Future<void> openFilterModal() async {
    await yearFilterDialog(
      context: context,
      selectedYear: state.selectedYear,
      years: state.availableYears,

      onSelected: (year) async {

        setState(() {
          if (year == null) return;
          state.selectedYear = year;
        });

        await loadData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: Color(0xFF000000),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 64,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
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
                      'Kelurahan',
                      style: TextStyle(
                        color: AppColors.whiteOne,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 26,
                      ),
                    ),

                    Text(
                      widget.nmKelurahan,
                      style: TextStyle(
                        color: AppColors.whiteOne,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 32,
                      ),
                    ),

                    Text(
                      'Kode: ${widget.kdPropinsi}.${widget.kdDati2}.${widget.kdKecamatan}.${widget.kdKelurahan}',
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
                child: state.isLoading
                  ? const StatCardsShimmer()
                  : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      StatCard(
                        title: 'Persentase Sudah Bayar terhadap total Wajib Pajak',
                        value: '${state.percentage.toStringAsFixed(1)} %',
                        gradient: getPercentageGradient(state.percentage),
                        titleColor: AppColors.blackThree,
                        titleSize: 10,
                        valueColor: AppColors.blackOne,
                        boxShadow: getStatCardShadow(state.percentage),
                        width: 115,
                        height: 135,
                        valueSize: 21,
                      ),

                      const SizedBox(width: 15),

                      StatCard(
                        title: 'Perbandingan Sudah Bayar terhadap total Wajib Pajak',
                        value: '${state.totalSudahBayar} / ${state.totalObjek}',
                        titleSize: 10,
                        valueSize: 25,
                        width: 115,
                        height: 135,
                      ),

                      const SizedBox(width: 15),

                      StatCard(
                        title: 'Sedang didata',
                        value: state.selectedYear == 2026 ?
                        state.totalObjek.toString() : "0",
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
                  hintText: 'Search Wajib Pajak',
                  onFilterTap: openFilterModal, 
                ),
              ),

              const SizedBox(height: 23),

              if (
                  state.selectedYear == 2026
                      ? state.filteredDetailsList.isEmpty
                      : state.filteredSpptList.isEmpty
                )
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    'No Wajib Pajak Found',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              else
                if (state.selectedYear == 2026)

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.filteredDetailsList.length,
                    itemBuilder: (context, index) {
                      final item = state.filteredDetailsList[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: OverviewVersion2Card(
                          tahun: '2026',
                          nop: '${item.kdPropinsi}.${item.kdDati2}.${item.kdKecamatan}.${item.kdKelurahan}.${item.kdBlok}.${item.noUrut}.${item.kdJnsOp}',
                          nmWpSppt: item.nmWpSppt,
                          status: 'Sedang didata',
                          statusGradient: AppGradient.mid,
                          terhutang: '-',
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 200),
                                pageBuilder: (_, animation, __) => DetailsPage(
                                  kdPropinsi: widget.kdPropinsi,
                                  kdDati2: widget.kdDati2,
                                  kdKecamatan: widget.kdKecamatan,
                                  kdKelurahan: item.kdKelurahan,
                                  kdBlok: item.kdBlok,
                                  noUrut: item.noUrut,
                                  kdJnsOp: item.kdJnsOp,
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
                        )
                      );
                    }
                  )

                else 
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.filteredSpptList.length,
                  itemBuilder: (context, index) {
                    final item = state.filteredSpptList[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: OverviewVersion2Card(
                        tahun: item.thnPajakSppt,
                        nop: '${item.kdPropinsi}.${item.kdDati2}.${item.kdKecamatan}.${item.kdKelurahan}.${item.kdBlok}.${item.noUrut}.${item.kdJnsOp}',
                        nmWpSppt: item.nmWpSppt,
                        status: item.statusPembayaranSppt == 1
                                    ? 'Lunas'
                                    : 'Belum Lunas',
                        statusGradient: item.statusPembayaranSppt == 1
                                    ? AppGradient.yesyes
                                    : AppGradient.nono,
                        terhutang: formatCurrency(item.pbbTerhutangSppt),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 200),
                              pageBuilder: (_, animation, __) => DetailsPage(
                                kdPropinsi: widget.kdPropinsi,
                                kdDati2: widget.kdDati2,
                                kdKecamatan: widget.kdKecamatan,
                                kdKelurahan: item.kdKelurahan,
                                kdBlok: item.kdBlok,
                                noUrut: item.noUrut,
                                kdJnsOp: item.kdJnsOp,
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
                      )
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

