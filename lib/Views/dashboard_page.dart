import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:testing/Models/listsppt.dart';
import 'package:testing/Models/listkecamatan.dart';

import 'activity_page.dart';
import 'kecamatan_page.dart';


import '../Services/api_service.dart';


class DashboardPage extends StatefulWidget {
  final Function(int)? onNavigate;

  const DashboardPage({
    super.key,
    this.onNavigate,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
    List<listkecamatan> kecamatan = [];

    List<FlSpot> chartSpots = []; 

    bool isLoading = false;

    Future<void> loadSpptChart() async {
      try {
        final result = await ApiService.fetchListSppt(2025,"51","1", "", "", "", 100, 0);

        // Store total per month
        Map<String, double> monthlyTotals = {};

        for (var item in result) {
          final month = item.tglTerbitSppt;

          monthlyTotals[month] =
              (monthlyTotals[month] ?? 0) +
              item.pbbYangHarusDibayarSppt.toDouble();
        }

        // Month order
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];

        // Convert into chart spots
        final spots = <FlSpot>[];

        for (int i = 0; i < months.length; i++) {
          final month = months[i];

          spots.add(
            FlSpot(
              i.toDouble(),
              monthlyTotals[month] ?? 0,
            ),
          );
        }

        setState(() {
          chartSpots = spots;
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }


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
      loadSpptChart();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xFF000000),

        body: isLoading
          ? const Center(
            child: CircularProgressIndicator(),
          )
          : Column(
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
                    
                    SizedBox(width: 20),

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
   

            AspectRatio(
              aspectRatio: 24/16,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20
                  ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),

                child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: chartSpots,
                          isCurved: true,
                          barWidth: 2,
                          
                        ),
                      ],
                    ),
                  ),

              ),
            ),

            SizedBox(height: 7),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xFF797979),
                      thickness: 2,
                    ),
                  ),

                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                  ),

                  GestureDetector(

        onTap: () {

            widget.onNavigate?.call(1);
          
        },

        child: Row(
          children: [

            Text(
              'View All',

              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 20,
                color: Colors.white,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 2,
              ),

              child: SvgPicture.asset(
                'assets/iconImage/right.svg',
                width: 16,
                height: 14,
              ),
            ),
          ],
        ),
                  ),
                    
                    
                ],
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
      )
      );
    }
  }
