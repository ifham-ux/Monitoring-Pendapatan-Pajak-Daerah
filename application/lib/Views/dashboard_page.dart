import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Widgets/widgets.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final state = DashboardState();

  Future<void> loadDashboard() async {
    setState(() {
      state.isLoading = true;
    });

    try {
      final dashboardResult =
        await DashboardService.loadDashboardData(
          state.selectedYear,
        );

    final kecamatanResult =
        await DashboardService.loadKecamatanOverview(
          state.selectedYear,
        );


      setState(() {
        state.chartData =
      dashboardResult["chartData"];

      state.totalWajibPajak =
          dashboardResult["totalWajibPajak"];

      state.totalSudahBayar =
          dashboardResult["totalSudahBayar"];

      state.percentage =
          dashboardResult["percentage"];

      state.kecamatan =
          kecamatanResult["kecamatan"];

      state.totalSudahBayarMap =
          kecamatanResult["totalSudahBayarMap"];

      state.totalWajibPajakMap =
          kecamatanResult["totalWajibPajakMap"];

      state.percentageMap =
          kecamatanResult["percentageMap"];

      });

    } finally {
      if (!mounted) return;
      setState(() {
        state.isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackOne,

      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: Row(
                children: state.years.map((year) {
                  final isSelected = state.selectedYear == year;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () async {
                          if (state.selectedYear == year) return;
                          setState(() {
                            state.selectedYear = year;
                          });
                          await loadDashboard();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.whiteOne
                                : AppColors.blackThree,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              year.toString(),
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.blackOne
                                    : AppColors.whiteOne,
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 13,
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

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: state.isLoading
                ? DashboardShimmer()
                : SingleChildScrollView(
                  child: Column(
                    children: [

                      const SizedBox(height: 16),

                      DashboardLineChart(
                        data: state.chartData,
                      ),

                      const SizedBox(height: 19),

                      Row(
                        children: [

                          Expanded(
                            child: Container(
                              height: 110,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.blackThree,
                                borderRadius: BorderRadius.circular(8),
                              
                              ),
                              child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Persentase Target (Semua Kecamatan)',
                                        style: const TextStyle(
                                          color: AppColors.whiteOne,
                                          fontFamily: 'PlusJakartaSans',
                                          fontSize: 11,
                                        ),

                                      ),
                                    ),

                                    Spacer(),

                                    Align(
                                      alignment: Alignment.bottomRight,

                                      child: ShaderMask(
                                      shaderCallback: (bounds) {
                                        return getPercentageGradient(
                                          state.percentage,
                                        ).createShader(bounds);
                                      },
                                    
                                      child: Text(
                                        '${state.percentage.toStringAsFixed(1)} %',
                                        style: TextStyle(
                                          color: AppColors.whiteOne,
                                          fontSize: 20,
                                          fontFamily: 'PlusJakartaSans'
                                        ),
                                      ),
                                    ),
                                      
                                    )
                                  ],
                                ),
                            ),
                          ),

                          SizedBox(width: 12),

                          Expanded(
                            child: Container(
                              height: 110,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.blackThree,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Sudah Bayar terhadap total Wajib Pajak (Semua Kecamatan) ',
                                        style: const TextStyle(
                                          color: AppColors.whiteOne,
                                          fontSize: 11,
                                          fontFamily: 'PlusJakartaSans',
                                        ),

                                      ),
                                    ),

                                    Spacer(),

                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        '${state.totalSudahBayar}/ ${state.totalWajibPajak}',
                                        style: const TextStyle(
                                          color: AppColors.whiteOne,
                                          fontFamily: 'PlusJakartaSans',
                                          fontSize: 20,
                                        ),

                                      )
                                    )
                                  ],
                                ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 26),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: AppColors.whiteThree,
                            ),
                          ),

                          SizedBox(width: 20),

                          Text(
                            'Progress Summary',
                            style: const TextStyle(
                              color: AppColors.whiteThree,
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),


                      SizedBox(height: 23),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.kecamatan.length,
                        itemBuilder: (context, index) {

                          final item = state.kecamatan[index];

                          final sudahBayar =
                              state.totalSudahBayarMap[item.kdKecamatan] ?? 0;

                          final wajibPajak =
                              state.totalWajibPajakMap[item.kdKecamatan] ?? 0;

                          final percentage =
                              state.percentageMap[item.kdKecamatan] ?? 0;

                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 14,
                            ),

                            padding: const EdgeInsets.all(16),

                            decoration: BoxDecoration(
                              color: AppColors.blackThree,
                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                Row(
                                  children: [
                                   Text(
                                        item.nmKecamatan,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'PlusJakartaSans'
                                        ),
                                      ),

                                      Spacer(),
                                    

                                    ShaderMask(
                                      shaderCallback: (bounds) {
                                        return getPercentageGradient(
                                          percentage,
                                        ).createShader(bounds);
                                      },
                                    
                                      child: Text(
                                        '${percentage.toStringAsFixed(1)} %',
                                        style: TextStyle(
                                          color: AppColors.whiteOne,
                                          fontSize: 20,
                                          fontFamily: 'PlusJakartaSans'
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                                
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child:SizedBox(
                                    height: 6,
                                    child: LinearProgressIndicator(
                                      value: percentage / 100,

                                      color: AppColors.whiteOne,
                                      backgroundColor:
                                          AppColors.whiteThree,
                                    ),

                                  ),
                                ),

                                const SizedBox(height: 15),

                                Text(
                                  "$sudahBayar / $wajibPajak Wajib Pajak",
                                  style: const TextStyle(
                                    color: AppColors.whiteTwo,
                                    fontFamily: 'PlusJakartaSans'
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 60),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}