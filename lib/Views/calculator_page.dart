import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _baseController = TextEditingController();

  double? _percentage;
  double? _baseValue;
  double? _resultValue;

  
  String? _details;

  @override
  void dispose() {
    _percentageController.dispose();
    _baseController.dispose();
    super.dispose();
  }

  double? _tryParseDouble(String raw) {
    final v = double.tryParse(raw.trim().replaceAll(',', '.'));
    return v;
  }

  void _calculate() {
    final p = _tryParseDouble(_percentageController.text);
    final b = _tryParseDouble(_baseController.text);

    if (p == null || b == null) {
      setState(() {
        _percentage = p;
        _baseValue = b;
        _resultValue = null;
        _details = 'Please enter valid numbers.';
      });
      return;
    }

    final result = b * (p / 100.0);
    setState(() {
      _percentage = p;
      _baseValue = b;
      _resultValue = result;
      _details = 'Calculation: $b × ($p / 100) = $result';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF000000),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LabeledInput(
                    label: 'Percentage (%)',
                    hint: 'e.g. 15',
                    controller: _percentageController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 14),

                  _LabeledInput(
                    label: 'Input number',
                    hint: 'e.g. 200000',
                    controller: _baseController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2894CA),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Calculate',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  if (_details != null) ...[
                    _Section(
                      title: 'Details',
                      child: Text(
                        _details!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  _Section(
                    title: 'Result',
                    child: _resultValue == null
                        ? const Text(
                            '—',
                            style: TextStyle(color: Colors.white70, fontSize: 22),
                          )
                        : Text(
                            _resultValue!.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LabeledInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _LabeledInput({
    required this.label,
    required this.hint,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 52,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color(0xFF1B1B1B),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFF2894CA), width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

