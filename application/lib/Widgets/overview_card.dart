import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/utils.dart';

class OverviewCard extends StatelessWidget {
  
  final int isCurrentYear;
  final bool isPercentageLoading;

  final String title;
  final double percentage;
  final String code;
  final int sudahBayar;
  final int wajibPajak;
  final int terhutang;
  final int realisasi;

  final List<Widget> bottomChildren;

  final VoidCallback onTap;

  const OverviewCard ({
    super.key,
    required this.isCurrentYear,
    required this.isPercentageLoading,
    required this.title,
    required this.percentage,
    required this.code,
    required this.wajibPajak,
    required this.sudahBayar,
    required this.terhutang,
    required this.realisasi,
    required this.bottomChildren,
    required this.onTap
  });

  @override 
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),

      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 220,
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: AppColors.blackThree,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column (
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.whiteOne,
                        fontSize: 20,
                        fontFamily: 'PlusJakartaSans'
                      ),
                    ),
                  ),

                  if (isPercentageLoading)

                  const SizedBox(
                    width: 20,
                    height: 20,

                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.whiteOne,
                    ),
                  )

                  else 

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
              
              const SizedBox(height: 3),

              Row(
                children: [
                  Text(
                    code,
                    style: const TextStyle(
                      color: AppColors.whiteTwo,
                      fontSize: 13,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),

                  const Spacer(),

                  Text(
                    isCurrentYear == 2026 ?
                    '-' : '$sudahBayar / $wajibPajak',
                    style: const TextStyle(
                      color: AppColors.whiteTwo,
                      fontSize: 12,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),

              Spacer(),

              Row(
                children: [
                  _InfoColumn(
                    title: 'Realisasi',
                    value: isCurrentYear == 2026 ?
                    "-" : formatCurrency(realisasi),
                  ),

                  const SizedBox(width: 40),

                  _InfoColumn(
                    title: 'Terhutang',
                    value: isCurrentYear == 2026 ?
                    "-" : formatCurrency(terhutang),
                  ),
                ],
              ),


              SizedBox(height: 12),

              Divider(
                thickness: 2,
                color: AppColors.blackFour,
              ),

              const SizedBox(height: 8),


              _InfoRow(
                separator: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.circle,
                    size: 5,
                    color: AppColors.whiteOne
                  ),
                ),

                trailing: SvgPicture.asset(
                  'assets/iconImage/forlink.svg',
                  width: 16,
                  height: 13
                ),

                children: bottomChildren,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _InfoRow extends StatelessWidget {
  final List<Widget> children;
  final Widget? separator;
  final Widget? trailing;

  const _InfoRow({
    required this.children,
    required this.separator,
    required this.trailing
  });

  @override
  Widget build(BuildContext context) {
    
      final rowChildren = <Widget>[];

      for (int i = 0; i < children.length; i++) {
        rowChildren.add(children[i]);

        if(separator != null && i != children.length - 1) {
          rowChildren.add(separator!);
        }
      }

      if (trailing != null) {
        rowChildren.add(const Spacer());
        rowChildren.add(trailing!);
      }

      return Row(
      children: rowChildren
    );
  }
}



class _InfoColumn extends StatelessWidget {

  final String title;
  final String value;

  const _InfoColumn({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.whiteTwo,
            fontFamily: 'PlusJakartaSans',
          ),
        ),

        const SizedBox(height: 3),

        Text(
          value,
          style: const TextStyle(
            color: AppColors.whiteOne,
            fontSize: 13,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ],
    );
  }
}
