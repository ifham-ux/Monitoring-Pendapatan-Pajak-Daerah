import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Widgets/widgets.dart';

import 'history_page.dart';
import 'calculator_page.dart';

class DetailsPage extends StatefulWidget {

  final String kdPropinsi;
  final String kdDati2;
  final String kdKecamatan;
  final String kdKelurahan;
  final String kdBlok;
  final String noUrut;
  final String kdJnsOp;

  final int selectedYear;

  const DetailsPage({
    super.key,
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,
    required this.selectedYear,
  });

  @override
  State<DetailsPage> createState() =>  _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final state = NopDetailState();


  Future<void> loadBiodata() async {
    final result = await DetailsService.loadBiodata(
      kdPropinsi: widget.kdPropinsi,
      kdDati2: widget.kdDati2,
      kdKecamatan: widget.kdKecamatan,
      kdKelurahan: widget.kdKelurahan,
      kdBlok: widget.kdBlok,
      noUrut: widget.noUrut,
      kdJnsOp: widget.kdJnsOp,
    );

    if (!mounted) return;

    setState(() {
      state.biodata = result;
    });
  }

  List<DetailField> buildFields() {
    final details = state.details;

    if (details == null) return [];
    
    final data = details.spptData;

    if (data == null) return [];
    return [
        DetailField(
          title: 'Status Pembayaran',
          value: data.statusPembayaranSppt == 1
              ? 'Lunas'
              : 'Belum Lunas',
        ),
        DetailField(
          title: 'Luas Bumi',
          value: '${data.luasBumiSppt} m\u00B2',
        ),
        DetailField(
          title: 'NJOP Bumi',
          value: formatCurrency(data.njopBumiSppt),
        ),
        DetailField(
          title: 'Luas Bangunan',
          value: '${data.luasBngSppt} m\u00B2',
        ),
        DetailField(
          title: 'NJOP Bangunan',
          value: formatCurrency(data.njopBngSppt),
        ),
        DetailField(
          title: 'Total NJOP',
          value: formatCurrency(data.njopSppt),
        ),
        DetailField(
          title: 'NJOPTKP',
          value: formatCurrency(data.njoptkpSppt),
        ),
        DetailField(
          title: 'NJKP',
          value: formatCurrency(data.njkpSppt),
        ),
        DetailField(
          title: 'PBB Terhutang',
          value: formatCurrency(data.pbbTerhutangSppt),
        ),
        DetailField(
          title: 'Faktor Pengurang',
          value: formatCurrency(data.faktorPengurangSppt),
        ),
        DetailField(
          title: 'Tanggal Terbit SPPT',
          value: data.tglTerbitSppt.toString(),
        ),
        DetailField(
          title: 'Tanggal Cetak SPPT',
          value: data.tglCetakSppt.toString(),
        ),
      ];
  }

  @override
  void initState() {
    super.initState();
    state.selectedYear = widget.selectedYear;
    loadYearData();
    loadBiodata();
  }

  Future<void> loadYearData() async {

    setState(() {
      state.isLoading = true;
    });

    try {
      final result = await DetailsService.loadData(
        selectedYear: state.selectedYear,
        kdPropinsi: widget.kdPropinsi,
        kdDati2: widget.kdDati2,
        kdKecamatan: widget.kdKecamatan,
        kdKelurahan: widget.kdKelurahan,
        kdBlok: widget.kdBlok,
        noUrut: widget.noUrut,
        kdJnsOp: widget.kdJnsOp,
      );
      if (!mounted) return;
      setState(() {
        state.details = result;
      });
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

  @override
  Widget build(BuildContext context) {
    final biodata = state.biodata;
    final fields = buildFields();
    final details = state.details;


    return Scaffold(
      backgroundColor: AppColors.blackOne,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                

                child: Row(
                  children: state.availableYears.map((year) {
                    final isSelected = state.selectedYear == year;

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),

                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              state.selectedYear = year;
                            });

                            await loadYearData();
                          },
                          
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 10,
                            ),

                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.whiteOne
                              : AppColors.blackThree,

                              borderRadius: BorderRadius.circular(6),
                            ),

                            child: Center(
                              child: Text(
                                year.toString(),
                                style: TextStyle(
                                  color: isSelected ? AppColors.blackOne
                                  : AppColors.whiteOne,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),
                            ),
                          ),

                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: state.isLoading
                    ? const DetailsContentShimmer()
                    : Column(
                    children: [
                      SizedBox(height: 20),
                      
                      
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        
                        child: Column(
                          children: [

                            SizedBox(height: 15),

                            Text(
                              'Nomor Objek Pajak',
                              style: TextStyle(
                                color: AppColors.whiteThree,
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 14,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              '${widget.kdPropinsi}.${widget.kdDati2}.${widget.kdKecamatan}.${widget.kdKelurahan}.${widget.kdBlok}.${widget.noUrut}.${widget.kdJnsOp}',
                              style: TextStyle(
                                color: AppColors.whiteOne,
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 24,
                              ),
                            ),

                            SizedBox(height: 20),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),

                              decoration: BoxDecoration(
                                gradient: details?.spptData?.statusPembayaranSppt == null
                                    ? AppGradient.mid
                                    : details?.spptData?.statusPembayaranSppt == 1
                                        ? AppGradient.yesyes
                                        : AppGradient.nono,
                                borderRadius: BorderRadius.circular(4),
                              ),

                              child: Text(
                                details?.spptData?.statusPembayaranSppt == null
                                    ? 'Sedang didata'
                                    : details?.spptData?.statusPembayaranSppt == 1
                                        ? 'Lunas'
                                        : 'Belum Lunas',
                                style: TextStyle(
                                  color: AppColors.blackOne,
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 36),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),

                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 27,
                            horizontal: 18
                          ),
                          width: double.infinity,

                          decoration: BoxDecoration(
                            color: AppColors.blackThree,
                            borderRadius: BorderRadius.circular(12)
                          ),


                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  bentoItem(
                                    title: 'Nama Wajib Pajak',
                                    value: state.selectedYear == 2026
                                        ? (biodata?.subjekPajak.nmWp ?? '')
                                        : (details?.spptData?.nmWpSppt ?? ''),
                                    width: double.infinity,
                                  ),

                                  bentoItem(
                                    title: 'Alamat Lengkap',
                                    value: biodata?.subjekPajak.jalanWp ?? '',
                                    width: double.infinity,
                                  ),
                                  
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),

                        child: GestureDetector(
                          onTap: () {
                            
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 200),

                                  pageBuilder: (_, animation, __) => HistoryPage(
                                    kdPropinsi: widget.kdPropinsi,
                                    kdDati2: widget.kdDati2,
                                    kdKecamatan: widget.kdKecamatan,
                                    kdKelurahan: widget.kdKelurahan,
                                    kdBlok: widget.kdBlok,
                                    noUrut: widget.noUrut,
                                    kdJnsOp: widget.kdJnsOp,
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
                            
                          

                          child: Container (
                            height: 50,
                            width: double.infinity,

                            decoration: BoxDecoration(
                              gradient: AppGradient.yesyes,
                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5
                              ),
                              
                              child: Row(
                                children: [

                                  Text(
                                    'View Summary',
                                    style: TextStyle(
                                      color: AppColors.blackOne,
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 16
                                    ),
                                  ),

                                  Spacer(),

                                  SvgPicture.asset(
                                    'assets/iconImage/forlink.svg',
                                    width: 16,
                                    height: 13,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.blackOne, BlendMode.srcIn
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (state.selectedYear == 2026) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Divider(
                              thickness: 2,
                              color: AppColors.blackThree,
                            ),
                          ),

                          const SizedBox(height: 25),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.blackThree,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Dalam proses pendataan atau pemeriksaan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.whiteThree,
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ] else ...[

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Divider(
                              thickness: 2,
                              color: AppColors.blackFour,
                            ),
                          ),

                          const SizedBox(height: 25),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 27,
                                horizontal: 18,
                              ),

                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.blackThree,
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: fields.length,
                                itemBuilder: (context, index) {
                                  final item = fields[index];

                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    child: Wrap(
                                      spacing: 12,
                                      runSpacing: 12,
                                      children: [
                                        bentoItem(
                                          title: item.title,
                                          value: item.value,
                                          width: double.infinity,
                                        ),

                                      ],
                                    ),

                                  );
                                   
                                  
                                },
                              ),
                            ),
                          ),
                        ],
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}