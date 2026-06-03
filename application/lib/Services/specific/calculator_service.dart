import '../../Models/models.dart';

class CalculatorService {
  static double? parseNumber(String text) {
    final cleaned = text
    .replaceAll('.', '')
    .replaceAll(',', '.');

    return double.tryParse(cleaned);
  }

  static CalculatorState calculate({
    required String percentageText,
    required String baseText,
  }) {
    final percentage = parseNumber(percentageText);
    final baseValue = parseNumber(baseText);

    if (percentage == null || baseValue == null) {
      return CalculatorState();
    }

    final result = baseValue * (percentage / 100);

    double differencePercent = percentage - 100;
    double differenceValue = baseValue * (differencePercent / 100);

    String description;

    if (percentage > 100) {
      description =
          'Bertambah';
    } else if (percentage < 100) {
      description =
          'Berkurang';
    } else {
      description = 'Tidak ada perubahan';
    }

    return CalculatorState(
      percentage: percentage,
      baseValue: baseValue,
      resultValue: result,
      percentageDescription: description,
      differenceValue: differenceValue.abs(),
    );
  }
}