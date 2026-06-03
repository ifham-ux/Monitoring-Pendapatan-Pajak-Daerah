import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Widgets/widgets.dart';
import 'calculator_page.dart';

import 'package:flutter_svg/flutter_svg.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,
  });

  final String kdPropinsi;
  final String kdDati2;
  final String kdKecamatan;
  final String kdKelurahan;
  final String kdBlok;
  final String noUrut;
  final String kdJnsOp;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final state = HistoryState();

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    setState(() {
      state.isLoading = true;
    
    });

    try {
      final result = await HistoryService.loadHistory(
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
        state.history = result;
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

  String _formatDate(dynamic value) {
    try {
      if (value == null) return '2026-09-01';
      if (value is DateTime) {
        return value.toString().split(' ').first;
      }
      return value.toString();
    } catch (_) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {

    final history = state.history;
    final isLoading = state.isLoading;


    return Scaffold(
      backgroundColor: AppColors.blackOne,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
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
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary of Objek Pajak',
                      style: TextStyle(
                        color: AppColors.whiteThree,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 16,
                      ),
                    ),

                    Text(
                      '${widget.kdPropinsi}.${widget.kdDati2}.${widget.kdKecamatan}.${widget.kdKelurahan}.${widget.kdBlok}.${widget.noUrut}.${widget.kdJnsOp}',
                      style: TextStyle(
                        color: AppColors.whiteOne,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: isLoading
                      ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (_, __) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: HistoryCardShimmer(),
                        ),
                      )
                          : history.isEmpty
                              ?  Text(
                                    'Data tidak ditemukan.',
                                    style: TextStyle(
                                      color: AppColors.whiteThree,
                                      fontFamily: 'PlusJakartaSans',
                                    ),
                                  )
                                
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: history.length,
                                  itemBuilder: (context, index) {
                                    final item = history[index];

                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 6),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: AppColors.blackThree,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row (
                                              children: [

                                                Text(
                                                  'Tahun: ${item.thnPajakSppt}',
                                                  style: TextStyle(
                                                    color: AppColors.whiteOne,
                                                    fontFamily: 'PlusJakartaSans',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                
                                                Spacer(),

                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),

                                                  decoration: BoxDecoration(
                                                    gradient: item.statusPembayaran  == 1
                                                        ? AppGradient.yesyes
                                                        : AppGradient.nono,
                                                  borderRadius: BorderRadius.circular(4),
                                                  ),

                                                  child: Text(
                                                    item.statusPembayaran == 1
                                                        ? 'Lunas'
                                                        : 'Belum Lunas',
                                                  style: TextStyle(
                                                    color: AppColors.blackOne,
                                                    fontFamily: 'PlusJakartaSans',
                                                    fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 6),

                                            Divider(
                                              color: AppColors.blackFour,
                                              thickness: 2
                                            ),
                                            

                                            const SizedBox(height: 5),

                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Nama Wajib Pajak',
                                                      style: TextStyle(
                                                        color: AppColors.whiteThree,
                                                        fontFamily: 'PlusJakartaSans',
                                                        fontSize: 12,
                                                      ),
                                                    ),

                                                    SizedBox(height: 3),

                                                    Text(
                                                      item.nmWpSppt,
                                                      style: TextStyle(
                                                        color: AppColors.whiteOne,
                                                        fontFamily: 'PlusJakartaSans',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ]
                                                ),

                                                Spacer(),

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'Terhutang',
                                                      style: TextStyle(
                                                        color: AppColors.whiteThree,
                                                        fontFamily: 'PlusJakartaSans',
                                                        fontSize: 12,
                                                      ),
                                                    ),

                                                    SizedBox(height: 3),

                                                    Text(
                                                      formatCurrency(item.pbbHarusDibayar),
                                                      style: TextStyle(
                                                        color: AppColors.whiteOne,
                                                        fontFamily: 'PlusJakartaSans',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ]
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 36),

                                            Text(
                                              'Terbit: ${_formatDate(item.tglTerbit)}',
                                              style: TextStyle(
                                                color: AppColors.whiteThree,
                                                fontFamily: 'PlusJakartaSans',
                                                fontSize: 12,
                                              ),
                                            ),

                                            SizedBox(height: 3),

                                            ShaderMask(
                                              shaderCallback: (bounds) =>
                                              AppGradient.nono.createShader(bounds),
                                              child:Text(
                                                'Jatuh Tempo: ${_formatDate(item.tglJatuhTempoSppt)}',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'PlusJakartaSans',
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                
                
              ),

              SizedBox(height: 60),
              
            ],
          ),
        ),
      ),
    );
  }
}

