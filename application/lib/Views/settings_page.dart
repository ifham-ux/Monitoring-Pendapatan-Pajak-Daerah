import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.grey.shade900,
                  child: const Icon(Icons.person, color: Colors.white, size: 44),
                ),

                const SizedBox(height: 16),

                Column(
                  children: [
                    Text(
                      'Isaac Newton',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        color: AppColors.whiteOne,
                        fontSize: 24,
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      'Administrator',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        color: AppColors.whiteThree,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.blackThree,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Account Information',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 16,
                            ),
                          ),

                          Spacer(),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),

                            decoration: BoxDecoration(
                              gradient: AppGradient.yesyes,
                              borderRadius: BorderRadius.circular(4),
                            ),

                            child: Text(
                              'Status: Active',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                color: AppColors.blackOne,
                                fontSize: 10,
                              )
                            )
                          ),
                        ],  
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),

                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 11
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 25, 25, 25),
                            borderRadius: BorderRadius.circular(6),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nomor Induk Pegawai',
                                style: TextStyle(
                                  color: AppColors.whiteThree,
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 12,
                                ),
                              ),

                              SizedBox(height: 4,),

                              
                              Text(
                                '001009922',
                                
                                style: TextStyle(
                                  color: AppColors.whiteOne,
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),

                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 11
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 25, 25, 25),
                            borderRadius: BorderRadius.circular(6),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                  color: AppColors.whiteThree,
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 12,
                                ),
                              ),

                              SizedBox(height: 4,),

                              
                              Text(
                                'bapenda123@sulit.bp.id',
                                
                                style: TextStyle(
                                  color: AppColors.whiteOne,
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 11
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  borderRadius: BorderRadius.circular(6),
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kode Provinsi',
                                      style: TextStyle(
                                        color: AppColors.whiteThree,
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 12,
                                      ),
                                    ),

                                    SizedBox(height: 4,),

                                    
                                    Text(
                                      '71 - BALI',
                                      
                                      style: TextStyle(
                                        color: AppColors.whiteOne,
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 12
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 11
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 25, 25, 25),
                                  borderRadius: BorderRadius.circular(6),
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kode Dati',
                                      style: TextStyle(
                                        color: AppColors.whiteThree,
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 12,
                                      ),
                                    ),

                                    SizedBox(height: 4,),

                                    
                                    Text(
                                      '51 - DENPASAR',
                                      
                                      style: TextStyle(
                                        color: AppColors.whiteOne,
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 12
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton.icon(
                    
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushAndRemoveUntil(
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 300),
                            pageBuilder: (_, animation, __) => const LoginPage(),
                            transitionsBuilder: (_, animation, __, child) {
                              return Stack(
                                children: [
                                  Container(color: Colors.black),
                                  FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                ],
                              );
                            },
                          ),
                          (route) => false,
                        );
                      });
                    },
                    
                    label: Text(
                      'Logout?',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 16,
                      )
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

