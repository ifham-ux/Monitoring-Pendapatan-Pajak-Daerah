import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';

Future<void> yearFilterDialog({
  required BuildContext context,
  required int? selectedYear,
  required List<int> years,
  required Function(int? year) onSelected,

  bool allowAllYears = false,
}) {

  return showDialog(
    context: context, builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),

        child: Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: const Color(0xFF222425),
            borderRadius: BorderRadius.circular(24),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                'Tahun Pajak',
                style: TextStyle(
                  color: AppColors.whiteOne,
                  fontSize: 20,
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: years.length + (allowAllYears ? 1 : 0),
                itemBuilder: (context, index) {

                  if (allowAllYears && index == 0) {
                    final isSelected = selectedYear == null;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onSelected(null);
                        },

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),

                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.blackFour
                                : AppColors.blackOne,

                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.whiteOne
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),

                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'All Years',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                              ),

                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );

                  }

                  final year = years[allowAllYears ? index - 1 : index];
                  final isSelected = selectedYear == year;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(

                      onTap: () {
                        Navigator.pop(context);
                        onSelected(year);
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),

                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.blackFour
                              : AppColors.blackOne,

                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.whiteOne
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                year.toString(),

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),
                            ),

                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}