import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';

import '../notification_page.dart';
import '../dashboard_page.dart';
import '../activity_page.dart';
import '../overdue_page.dart';
import '../settings_page.dart';
import '../calculator_page.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  late final PageController _pageController;

  int currentIndex = 0;

  final pageTitles = [
    'Dashboard',
    'Activity',
    'Overdue',
    'Settings',
  ];


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    if (index == currentIndex) return;

    setState(() {
      currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackOne,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.startFloat,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 64,
        backgroundColor: AppColors.blackOne,
        elevation: 0,

        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            pageTitles[currentIndex],
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 28,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [
                    Color(0xFF82FFAE),
                    Color(0xFF2894CA),
                  ],
                ).createShader(
                  const Rect.fromLTWH(0, 0, 300, 70),
                ),
            ),
          ),
        ),

        actions: [
          if (currentIndex == 0)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationPage(),
                    ),
                  );
                },
              ),
            ),
        ],
      ),

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DashboardPage(),
          ActivityPage(),
          OverduePage(),
          SettingsPage(),
        ],
      ),

      floatingActionButton: currentIndex == 3
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(
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
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration:
                            const Duration(milliseconds: 200),
                        pageBuilder: (_, animation, __) =>
                            const CalculatorPage(),
                        transitionsBuilder:
                            (_, animation, __, child) {
                          final curve = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          );

                          return FadeTransition(
                            opacity: curve,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.15, 0),
                                end: Offset.zero,
                              ).animate(curve),
                              child: child,
                            ),
                          );
                        },
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
                    colorFilter: const ColorFilter.mode(
                      AppColors.blackOne,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.white.withValues(alpha: 0.07),
          highlightColor: Colors.white.withValues(alpha: 0.12),
        ),
        child: SizedBox(
          height: 125,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,

            showSelectedLabels: false,
            showUnselectedLabels: false,

            backgroundColor: AppColors.blackOne,

            onTap: changeTab,

            items: [
              _buildNavItem(
                asset: 'assets/iconImage/dashboard.svg',
                selected: currentIndex == 0,
                width: 19,
                height: 22,
                label: 'Dashboard',
              ),
              _buildNavItem(
                asset: 'assets/iconImage/activity.svg',
                selected: currentIndex == 1,
                width: 19,
                height: 22,
                label: 'Activity',
              ),
              _buildNavItem(
                asset: 'assets/iconImage/dueIcon.svg',
                selected: currentIndex == 2,
                width: 26,
                height: 29,
                label: 'Overdue',
              ),
              _buildNavItem(
                asset: 'assets/iconImage/settings.svg',
                selected: currentIndex == 3,
                width: 19,
                height: 22,
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String asset,
    required bool selected,
    required double width,
    required double height,
    required String label,
  }) {
    Widget icon = SvgPicture.asset(
      asset,
      width: width,
      height: height,
    );

    if (selected) {
      icon = ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [
              Color(0xFF82FFAE),
              Color(0xFF2894CA),
            ],
          ).createShader(bounds);
        },
        child: SvgPicture.asset(
          asset,
          width: width,
          height: height,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      );
    }

    return BottomNavigationBarItem(
      label: label,
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 49),
        child: icon,
        
      ),
    );
  }
}

