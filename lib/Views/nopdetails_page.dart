import 'package:flutter/material.dart';

import '../Models/getbynop.dart';
import '../Models/getsppthistory.dart';
import '../Models/gettahunsppt.dart';
import '../Models/listdetails.dart';

import '../Services/api_service.dart';

class NopDetailsPage extends StatefulWidget {

  final String kdPropinsi;
  final String kdDati2;
  final String kdKecamatan;
  final String kdKelurahan;
  final String kdBlok;
  final String noUrut;
  final String kdJnsOp;

  const NopDetailsPage({
    super.key,

    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,
  });

  @override
  State<NopDetailsPage> createState() =>
      _NopDetailsPageState();
}

class _NopDetailsPageState
    extends State<NopDetailsPage> {

  List<getsppthistory> history = [];

  gettahunsppt? nopdetail;

  getbynop? nopData;  // FIX #1: Changed from List to single object

  listdetails? nopObject;

  bool isLoading = false;

  bool isDefaultNopMode = true;

  String selectedYear = '2026';

  @override
  void initState() {
    super.initState();

    loadInitialData();
  }

  Future<void> loadInitialData() async {

    setState(() {
      isLoading = true;
    });

    try {

      // HISTORY
      final historyResult =
          await ApiService.fetchGetSpptHistory(

        widget.kdPropinsi,
        widget.kdDati2,
        widget.kdKecamatan,
        widget.kdKelurahan,
        widget.kdBlok,
        widget.noUrut,
        widget.kdJnsOp,
      );

      final byNopResult =
          await ApiService.fetchGetByNop(

        widget.kdPropinsi,
        widget.kdDati2,
        widget.kdKecamatan,
        widget.kdKelurahan,
        widget.kdBlok,
        widget.noUrut,
        widget.kdJnsOp,
      );

      final detailResult =
          await ApiService.fetchListDetails(

        widget.kdPropinsi,
        widget.kdDati2,
        widget.kdKecamatan,
        widget.kdKelurahan,
      );

      
      final matchedData = detailResult.firstWhere(

        (item) =>

            item.kdBlok == widget.kdBlok &&
            item.noUrut == widget.noUrut &&
            item.kdJnsOp == widget.kdJnsOp,

        orElse: () => listdetails(

          kdPropinsi: '',
          kdDati2: '',
          kdKecamatan: '',
          kdKelurahan: '',
          kdBlok: '',
          noUrut: '',
          kdJnsOp: '',

          nmWpSppt: '',
          jalanOp: '',

          luasBumi: 0,
          njopBumi: 0,
        ),
      );

      // FIX #1: Get first item from list, not cast entire list
      final nopDataItem = byNopResult.isNotEmpty 
        ? byNopResult.first 
        : null;

      // FIX #2: Set default year to most recent from history, or 2026
      String defaultYear = '2026';
      if (history.isNotEmpty) {
        history.sort((a, b) => 
          int.parse(b.thnPajakSppt.toString())
            .compareTo(int.parse(a.thnPajakSppt.toString())));
        defaultYear = history.first.thnPajakSppt.toString();
      }

      setState(() {

        history = historyResult;

        nopData = nopDataItem;

        nopObject = matchedData;

        selectedYear = defaultYear;

        isDefaultNopMode = true;
      });

    } catch (e) {

      debugPrint(e.toString());

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadHistoryDetail(
    String tahun,
  ) async {

    setState(() {
      isLoading = true;
    });

    try {

      final result =
          await ApiService.fetchGetTahunSppt(

        widget.kdPropinsi,
        widget.kdDati2,
        widget.kdKecamatan,
        widget.kdKelurahan,
        widget.kdBlok,
        widget.noUrut,
        widget.kdJnsOp,
        tahun,
      );

      setState(() {

        nopdetail = result;

        selectedYear = tahun;

        isDefaultNopMode = false;
      });

    } catch (e) {

      debugPrint(e.toString());

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> backToDefault2026() async {

    setState(() {

      selectedYear = '2026';

      isDefaultNopMode = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading && nopData == null) {

      return const Scaffold(

        backgroundColor: Colors.black,

        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final detailNop = isDefaultNopMode

        ? [

            {
              'title': 'Luas Bumi',
              'value': nopObject?.luasBumi ?? 0,
            },

            {
              'title': 'NJOP Bumi',
              'value': nopObject?.njopBumi ?? 0,
            },

            {
              'title': 'Tanggal Pendataan',
              'value':
                  nopData?.tglPendataanOp ?? '-',
            },

            {
              'title': 'Nama Pendata',
              'value':
                  nopData?.nmPendataanOp ?? '-',
            },

            {
              'title': 'NIP Pendata',
              'value':
                  nopData?.nipPendata ?? '-',
            },

            {
              'title': 'Tanggal Pemeriksaan',
              'value':
                  nopData?.tglPemeriksaanOp ?? '-',
            },

            {
              'title': 'Nama Pemeriksa',
              'value':
                  nopData?.nmPemeriksaanOp ?? '-',
            },

            {
              'title': 'NIP Pemeriksa',
              'value':
                  nopData?.nipPemeriksaOp ?? '-',
            },

            {
              'title': 'Subjek Pajak',
              'value':
                  nopData?.subjekPajak?.nmWp ?? '-',
            },

            {
              'title': 'Alamat WP',
              'value':
                  nopData?.subjekPajak?.jalanWp ?? '-',
            },

            {
              'title': 'NPWP',
              'value':
                  nopData?.subjekPajak?.npwp ?? '-',
            },

            {
              'title': 'Email',
              'value':
                  nopData?.subjekPajak?.emailWp ?? '-',
            },
          ]

        : [

            {
              'title': 'Luas Bumi',
              'value':
                  nopdetail?.luasBumiSppt ?? 0,
            },

            {
              'title': 'NJOP Bumi',
              'value':
                  nopdetail?.njopBumiSppt ?? 0,
            },

            {
              'title': 'Luas Bangunan',
              'value':
                  nopdetail?.luasBngSppt ?? 0,
            },

            {
              'title': 'NJOP Bangunan',
              'value':
                  nopdetail?.njopBngSppt ?? 0,
            },

            {
              'title': 'NJOP SPPT',
              'value':
                  nopdetail?.njopSppt ?? 0,
            },

            {
              'title': 'NJOPTKP',
              'value':
                  nopdetail?.njoptkpSppt ?? 0,
            },

            {
              'title': 'NJKP',
              'value':
                  nopdetail?.njkpSppt ?? 0,
            },

            {
              'title': 'Nominal PBB',
              'value':
                  nopdetail
                      ?.pbbYangHarusDibayarSppt ??
                  0,
            },
          ];

    return Scaffold(

      backgroundColor: const Color(0xFF000000),

      appBar: AppBar(

        backgroundColor: const Color(0xFF000000),

        iconTheme:
            const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 20),

            // HEADER

            Container(

              margin:
                  const EdgeInsets.symmetric(
                horizontal: 30,
              ),

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: const Color(0xFF222425),

                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: Row(

                children: [

                  CircleAvatar(

                    radius: 35,

                    backgroundColor: Colors.white,

                    child: const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 30),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(

                          isDefaultNopMode
                              ? nopData
                                      ?.subjekPajak
                                      ?.nmWp ??
                                  '-'
                              : nopdetail
                                      ?.nmWpSppt ??
                                  '-',

                          style: const TextStyle(

                            color: Colors.white,

                            fontSize: 16,

                            fontFamily:
                                'PlusJakartaSans',
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(

                          isDefaultNopMode
                              ? nopData
                                      ?.subjekPajak
                                      ?.jalanWp ??
                                  '-'
                              : nopdetail
                                      ?.jlnWpSppt ??
                                  '-',

                          style: const TextStyle(

                            color: Colors.white,

                            fontSize: 10,

                            fontFamily:
                                'PlusJakartaSans',
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(

                          'Tahun Data : $selectedYear',

                          style: const TextStyle(

                            color: Colors.white,

                            fontSize: 10,

                            fontFamily:
                                'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // HISTORY

            Container(

              margin:
                  const EdgeInsets.symmetric(
                horizontal: 30,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    'Riwayat Tahun SPPT',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily:
                          'PlusJakartaSans',
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(

                    height: 55,

                    child: ListView(

                      scrollDirection:
                          Axis.horizontal,

                      children: [

                        // DEFAULT 2026

                        GestureDetector(

                          onTap: () async {

                            await backToDefault2026();
                          },

                          child: AnimatedContainer(

                            duration:
                                const Duration(
                              milliseconds: 200,
                            ),

                            margin:
                                const EdgeInsets.only(
                              right: 10,
                            ),

                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),

                            decoration: BoxDecoration(

                              color: selectedYear ==
                                      '2026'
                                  ? Colors.white
                                  : const Color(
                                      0xFF222425,
                                    ),

                              borderRadius:
                                  BorderRadius.circular(
                                10,
                              ),
                            ),

                            child: Center(

                              child: Text(

                                '2026',

                                style: TextStyle(

                                  color:
                                      selectedYear ==
                                              '2026'
                                          ? Colors.black
                                          : Colors.white,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // HISTORY DATA

                        ...history.map((historyItem) {

                          final year =
                              historyItem
                                  .thnPajakSppt
                                  .toString();

                          final isSelected =
                              selectedYear == year;

                          return GestureDetector(

                            onTap: () async {

                              await loadHistoryDetail(
                                year,
                              );
                            },

                            child: AnimatedContainer(

                              duration:
                                  const Duration(
                                milliseconds: 200,
                              ),

                              margin:
                                  const EdgeInsets.only(
                                right: 10,
                              ),

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),

                              decoration:
                                  BoxDecoration(

                                color: isSelected
                                    ? Colors.white
                                    : const Color(
                                        0xFF222425,
                                      ),

                                borderRadius:
                                    BorderRadius.circular(
                                  10,
                                ),
                              ),

                              child: Center(

                                child: Text(

                                  year,

                                  style: TextStyle(

                                    color:
                                        isSelected
                                            ? Colors.black
                                            : Colors.white,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // DETAILS TITLE

            Container(

              margin:
                  const EdgeInsets.symmetric(
                horizontal: 30,
              ),

              child: Row(

                children: [

                  const Expanded(

                    child: Divider(
                      color: Color(0xFF797979),
                      thickness: 2,
                    ),
                  ),

                  const SizedBox(width: 13),

                  const Text(

                    'Details',

                    style: TextStyle(
                      fontFamily:
                          'PlusJakartaSans',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // DETAIL CONTENT

            Container(

              margin:
                  const EdgeInsets.symmetric(
                horizontal: 30,
              ),

              padding:
                  const EdgeInsets.symmetric(
                vertical: 10,
              ),

              decoration: BoxDecoration(

                color: const Color(0xFF222425),

                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: Column(

                children:
                    detailNop.map((data) {

                  return Container(

                    margin:
                        const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),

                    padding:
                        const EdgeInsets.all(15),

                    decoration: BoxDecoration(

                      color:
                          const Color(0xFF191919),

                      borderRadius:
                          BorderRadius.circular(5),
                    ),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(

                          data['title'].toString(),

                          style: const TextStyle(

                            color: Colors.white,

                            fontFamily:
                                'PlusJakartaSans',
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(

                          data['value'].toString(),

                          style: const TextStyle(

                            color: Colors.white70,

                            fontFamily:
                                'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  );

                }).toList(),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}