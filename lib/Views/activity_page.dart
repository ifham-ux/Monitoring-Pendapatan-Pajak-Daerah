import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:testing/Models/listkecamatan.dart';
import 'kecamatan_page.dart';
import '../Services/api_service.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}


class _ActivityPageState extends State<ActivityPage> {

  List<listkecamatan> kecamatan = [];

  bool isLoading = false;

  Future<void> loadKecamatan() async {
      setState(() {
        isLoading = true;
      });

      try {
        final result = await ApiService.fetchKecamatan("51", "71");

        setState(() {
          kecamatan = result;
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
      loadKecamatan();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      

      body: Column(
        children: [
          Container(
              height: 95,
              margin: EdgeInsets.only(
                right: 25,
                left: 25,
                top: 15,
                bottom: 5
              ),

                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFF222425),
                        ),
                      ),
                    ),
                    
                    SizedBox(width: 15),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFF222425),
                        ),
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFF222425),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 20,),

            SizedBox(
                            height: 55,
                            width: 360,

                        child: TextField(

                              

                        style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Color(0xFF797979),
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15,
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),

                        

                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: SvgPicture.asset(
                            'assets/iconImage/search.svg',
                            width: 20,
                            height: 16,
                          ),
                        ),

                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                          ),
                          ),


                          SizedBox(height: 12),

            
            SizedBox(
                  height: 275,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: kecamatan.length,
                    itemBuilder: (context, index) {
                      final item = kecamatan[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10
                        ),

                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (context) => KecamatanPage(
                                  kdPropinsi: "51",
                                  kdDati2: "71",
                                  kdKecamatan: item.kdKecamatan,
                                  nmKecamatan: item.nmKecamatan,
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
                              color: Color(0xFF222425)
                              
                            ),
                            child: ListTile(
                              title: Text(
                                item.nmKecamatan,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PlusJakartaSans'
                                  ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                
              ),

        ],
      ),
    );
  }
}