import 'package:flutter/material.dart';
import 'package:testing/Views/kelurahan_page.dart';

import '../Models/listkelurahan.dart';
import '../Services/api_service.dart';

class KecamatanPage extends StatefulWidget {

  final String kdPropinsi;
  final String kdDati2;
  final String kdKecamatan;
  final String nmKecamatan;

  const KecamatanPage({
    super.key,
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.nmKecamatan,
  });

  @override
  State<KecamatanPage> createState() => _KecamatanPageState();
}

class _KecamatanPageState extends State<KecamatanPage> {

  List<listkelurahan> kelurahan = [];

  bool isLoading = false;

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
              widget.nmKecamatan,

              style: TextStyle(
                fontSize: 18,
                fontFamily: 'PlusJakartaSans',
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20,),

            

            SizedBox(
              height: 275,  
              child: ListView.builder(
              itemCount: kelurahan.length,

              itemBuilder: (context, index) {

                final item = kelurahan[index];

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
                                builder: (context) => KelurahanPage(
                                  kdPropinsi: widget.kdPropinsi,
                                  kdDati2: widget.kdDati2,
                                  kdKecamatan: widget.kdKecamatan,
                                  kdKelurahan: item.kdKelurahan,
                                  nmKelurahan: item.nmKelurahan,
                                
                                
                                )
                              )
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

                    child: ListTile(

                      title: Text(
                        item.nmKelurahan,

                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'PlusJakartaSans',
                        ),
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