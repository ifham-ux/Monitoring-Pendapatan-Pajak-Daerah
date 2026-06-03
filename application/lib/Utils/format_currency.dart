import 'package:intl/intl.dart';

String formatCurrency(num value) {

  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 2,
  ).format(value);
}