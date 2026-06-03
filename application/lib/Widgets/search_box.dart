import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onFilterTap;

  const SearchBox({
    super.key,
    required this.controller,
    required this.hintText,
    this.onFilterTap,
  });

  @override 
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: TextField(
            controller: controller,

            style: const TextStyle(
              color: AppColors.whiteOne,
            ),
            cursorColor: Colors.white,
            
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.whiteThree,
              ),

              filled: true,
              fillColor: AppColors.blackThree,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18
              ),

              

              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: Icon(
                  Icons.search,
                  color: AppColors.whiteOne,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: AppColors.whiteOne, 
                  width: 2
                ),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              )
            ),
          ),
        ),

        const SizedBox(width: 15),

        GestureDetector(
          onTap: onFilterTap,

          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18
            ),

            decoration: BoxDecoration(
              color: AppColors.blackThree,
              borderRadius: BorderRadius.circular(30),
            ),

            child: const Icon(
              Icons.calendar_month_sharp,
              color: AppColors.whiteOne,
            ),
          ),
        ),
      ],
    );
  }
}