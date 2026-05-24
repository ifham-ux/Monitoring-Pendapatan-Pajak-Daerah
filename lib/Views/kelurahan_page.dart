import 'package:flutter/material.dart';
import 'package:testing/Models/listdetails.dart';

import 'nopdetails_page.dart';
import '../Models/listkelurahan.dart';
import '../Services/api_service.dart';

class KelurahanPage extends StatefulWidget {

  final String kdPropinsi;
  final String kdDati2;
  final String kdKecamatan;
  final String kdKelurahan;
  final String nmKelurahan;

  const KelurahanPage({
    super.key,
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.nmKelurahan
  });

  @override
  State<KelurahanPage> createState() => _KelurahanPageState();
}

class _KelurahanPageState extends State<KelurahanPage> {

  List<listdetails> nop = [];
  List<listkelurahan> kelurahan = [];

  bool isLoading = false;

  Future<void> loadNop() async {
      setState(() {
        isLoading = true;
      });

      try {
        final result = await ApiService.fetchListDetails(
          widget.kdPropinsi,
          widget.kdDati2,
          widget.kdKecamatan,
          widget.kdKelurahan
        );

        debugPrint('KelurahanPage: nop.length=${result.length}');

        setState(() {
          nop = result;
        });
      } catch (e) {
        debugPrint(e.toString());
      } finally {

        setState(() {
          isLoading = false;
        });
      }
  }


  Future<void> loadKelurahan() async {

    setState(() {
      isLoading = true;
    });

    try {

      final result = await ApiService.fetchKelurahan(
        widget.kdPropinsi,
        widget.kdDati2,
        widget.kdKecamatan,
      );

      setState(() {
        kelurahan = result.cast<listkelurahan>();
      });

    } catch (e) {

      debugPrint(e.toString());

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadKelurahan();
    loadNop();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF000000),

      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        iconTheme: const IconThemeData(
    color: Colors.white,
        ),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )

          : Column (
            children: [

              AspectRatio(
              aspectRatio: 24/15,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20
                  ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),

            Text(
              widget.nmKelurahan,

              style: TextStyle(
                fontSize: 18,
                fontFamily: 'PlusJakartaSans',
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20,),

            
            SizedBox(
              height: 300,  
              child: nop.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
              itemCount: nop.length,

              itemBuilder: (context, index) {

                final item = nop[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),

                  child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (context) => NopDetailsPage(
                                  kdPropinsi: widget.kdPropinsi,
                                  kdDati2: widget.kdDati2,
                                  kdKecamatan: widget.kdKecamatan,
                                  kdKelurahan: widget.kdKelurahan,
                                  kdBlok: item.kdBlok,
                                  noUrut: item.noUrut,
                                  kdJnsOp: item.kdJnsOp
                                ),
                              ),
                            );
                          },

                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 58
                              ),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF222425),
                    ),

                    child: Text(

                    "${item.kdPropinsi} - "
                    "${item.kdDati2} - "
                    "${item.kdKecamatan} - "
                    "${item.kdKelurahan} - "
                    "${item.kdBlok} - "
                    "${item.noUrut} - " 
                    "${item.kdJnsOp}"
                    ,

                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),

                  ),
                  ),
                );
              },
            ),

            )
            
            






            ],
          ),
          
          
          
            
    );
  }
}