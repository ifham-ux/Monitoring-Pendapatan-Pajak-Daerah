import 'package:flutter/material.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Utils/utils.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';
import 'package:monitoring_pendapatan_pajak_daerah/Services/services.dart';

import 'package:monitoring_pendapatan_pajak_daerah/Widgets/widgets.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';


class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  CalculatorState state = CalculatorState();

  final percentageController = TextEditingController();
  final baseController = TextEditingController();

  @override
  void dispose() {
    percentageController.dispose();
    baseController.dispose();
    super.dispose();
  }

  void _calculate() {
    setState(() {
      state = CalculatorService.calculate(
        percentageText: percentageController.text,
        baseText: baseController.text,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackOne,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.whiteOne),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blackTwo,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          'Input Number',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'PlusJakartaSans',
                            color: AppColors.whiteOne,
                          ),
                        ),

                        SizedBox(height: 12),

                        TextField(
                          controller: baseController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            CurrencyTextInputFormatter.currency(
                              locale: 'id',
                              decimalDigits: 0,
                              symbol: '',
                            ),
                          ],
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),

                            hintText: 'e.g. 0',
                            hintStyle: const TextStyle(
                              color: AppColors.whiteThree,
                              fontFamily:'PlusJakartaSans',
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 45, 45, 45),
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
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 18),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          'Percentage',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'PlusJakartaSans',
                            color: AppColors.whiteOne,
                          ),
                        ),

                        SizedBox(height: 12),

                        TextField(
                          controller: percentageController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),

                            hintText: 'e.g. 0.00 %',
                            hintStyle: const TextStyle(
                              color: AppColors.whiteThree,
                              fontFamily:'PlusJakartaSans',
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 45, 45, 45),
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
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  AppColors.whiteOne,
                    foregroundColor: AppColors.blackOne,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Calculate',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                )
              ),

              SizedBox(height: 25),

              if (state.resultValue != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.whiteThree,
                            thickness: 2,
                          ),
                        ),

                        SizedBox(width: 12),

                        Text(
                          'Calculation Details',
                          style: TextStyle(
                            color: AppColors.whiteThree,
                            fontSize: 18,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 12),

                    Row(
                      children: [
                        Text(
                          'Nominal Input',
                          style: TextStyle(
                            color: AppColors.whiteThree,
                            fontSize: 15,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),

                        Spacer(),

                        Text(
                          formatCurrency(state.baseValue?.toInt() ?? 0),
                          style: TextStyle(
                            color: AppColors.whiteThree,
                            fontSize: 15,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    Divider(
                      color: AppColors.blackThree,
                      thickness: 1,
                    ),

                    SizedBox(height: 6),

                    Row(
                      children: [
                        Text(
                          'Percentage',
                          style: TextStyle(
                            color: AppColors.whiteThree,
                            fontSize: 15,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),

                        Spacer(),

                        Text(
                          '${state.percentage?.toStringAsFixed(2) ?? '-'} %',
                          style: TextStyle(
                            color: AppColors.whiteThree,
                            fontSize: 15,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    Divider(
                      color: AppColors.blackThree,
                      thickness: 1,
                    ),

                    SizedBox(height: 6),

                    Row(
                      children: [
                        Text(
                          state.percentageDescription ?? '-',
                          style: TextStyle(
                            color: AppColors.whiteThree,
                            fontSize: 15,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),

                        Spacer(),

                        Text(
                          formatCurrency(state.differenceValue ?? 0),
                          style: TextStyle(
                            color: AppColors.whiteThree,
                            fontSize: 15,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: 25),

                Section(
                  title: 'Result',
                  value: state.resultValue == null
                      ? '-'
                      : formatCurrency(state.resultValue ?? 0),
                ),
              ],
            ]
          ),
        ),
      ),
    );
  }
}
