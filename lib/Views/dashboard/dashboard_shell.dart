import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../dashboard_page.dart';
import '../activity_page.dart';
import '../calculator_page.dart';
import '../settings_page.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int currentIndex = 0;

  final pageTitles = [
    'Dashboard',
    'Activity',
    'Calculator',
    'Settings',
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      

      appBar: AppBar(
        automaticallyImplyLeading: false,

        toolbarHeight: 80,
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
            child: Text(
              pageTitles[currentIndex],

              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 36,

                foreground: Paint()
                ..shader = LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(currentIndex * 2),
                colors: const [
                Color(0xFF82FFAE),
                Color(0xFF2894CA),
              ],
              ).createShader(
              const Rect.fromLTWH(0, 0, 300, 70),
              ),
            ),
          ),
        ),      
      ),

      
      body: IndexedStack(
  index: currentIndex,

  children: [

    DashboardPage(
      onNavigate: (index) {

        setState(() {
          currentIndex = index;
        });
      },
    ),

    ActivityPage(),

    CalculatorPage(),

    SettingsPage(),
  ],
),

      
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.white.withValues(alpha: 0.07),
          highlightColor: Colors.white.withValues(alpha: 0.12),
        ),

        child: SizedBox(
          height: 112,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,

            showSelectedLabels: false,
            showUnselectedLabels: false,

            backgroundColor: const Color(0xFF000000),

            onTap: (index) {
              setState(() => currentIndex = index);
            },

            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: currentIndex == 0
                        ? ShaderMask(
                            key: const ValueKey('gradient'),
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFF82FFAE),
                                  Color(0xFF2894CA)
                                ],
                              ).createShader(bounds);
                            },
                            child: SvgPicture.asset(
                              'assets/iconImage/dashboard.svg',
                              key: const ValueKey('white'),
                              width: 19,
                              height: 22,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/iconImage/dashboard.svg',
                            key: const ValueKey('plain'),
                            width: 19,
                            height: 22,
                          ),
                  ),
                ),
                label: 'Dashboard',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: currentIndex == 1
                        ? ShaderMask(
                            key: const ValueKey('gradient'),
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFF82FFAE),
                                  Color(0xFF2894CA)
                                ],
                              ).createShader(bounds);
                            },
                            child: SvgPicture.asset(
                              'assets/iconImage/activity.svg',
                              key: const ValueKey('white'),
                              width: 19,
                              height: 22,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/iconImage/activity.svg',
                            key: const ValueKey('plain'),
                            width: 19,
                            height: 22,
                          ),
                  ),
                ),
                label: 'Activity',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: currentIndex == 2
                        ? ShaderMask(
                            key: const ValueKey('gradient'),
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFF82FFAE),
                                  Color(0xFF2894CA)
                                ],
                              ).createShader(bounds);
                            },
                            child: SvgPicture.asset(
                              'assets/iconImage/calculator.svg',
                              key: const ValueKey('white'),
                              width: 19,
                              height: 22,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/iconImage/calculator.svg',
                            key: const ValueKey('plain'),
                            width: 19,
                            height: 22,
                          ),
                  ),
                ),
                label: 'Calculator',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: currentIndex == 3
                        ? ShaderMask(
                            key: const ValueKey('gradient'),
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFF82FFAE),
                                  Color(0xFF2894CA)
                                ],
                              ).createShader(bounds);
                            },
                            child: SvgPicture.asset(
                              'assets/iconImage/settings.svg',
                              key: const ValueKey('white'),
                              width: 19,
                              height: 22,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/iconImage/settings.svg',
                            key: const ValueKey('plain'),
                            width: 19,
                            height: 22,
                          ),
                  ),
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}