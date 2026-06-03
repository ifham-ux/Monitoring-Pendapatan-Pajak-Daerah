import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteOne),
        backgroundColor: Colors.transparent,
      ),

      body: const Center(
        child: Text(
          "No notifications yet",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}