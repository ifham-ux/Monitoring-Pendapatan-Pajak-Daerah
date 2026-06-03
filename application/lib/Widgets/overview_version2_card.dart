import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class OverviewVersion2Card extends StatelessWidget {
  final String tahun;
  final String nop;
  final String nmWpSppt;
  final String status;
  final Gradient statusGradient;
  final String terhutang;
  final VoidCallback? onTap;


  const OverviewVersion2Card({
    super.key,
    required this.tahun,
    required this.nop,
    required this.nmWpSppt,
    required this.status,
    required this.statusGradient,
    required this.terhutang,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
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
                  'Tahun: $tahun',
                  style: const TextStyle(
                    color: AppColors.whiteOne,
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 12,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: statusGradient,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: AppColors.blackOne,
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            const Divider(
              color: AppColors.blackFour,
              thickness: 2,
            ),

            const SizedBox(height: 5),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nomor Objek Pajak',
                  style: TextStyle(
                    color: AppColors.whiteThree,
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 11,
                  ),
                ),
                Text(
                  nop,
                  style: const TextStyle(
                    color: AppColors.whiteOne,
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Wajib Pajak',
                      style: TextStyle(
                        color: AppColors.whiteThree,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      nmWpSppt,
                      style: const TextStyle(
                        color: AppColors.whiteOne,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Terhutang',
                      style: TextStyle(
                        color: AppColors.whiteThree,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      terhutang,
                      style: const TextStyle(
                        color: AppColors.whiteOne,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}