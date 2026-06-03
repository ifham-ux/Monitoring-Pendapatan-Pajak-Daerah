import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';

class OverdueItem {
  final ListSpptRow sppt;

  OverdueItem({
    required this.sppt,
  });

  factory OverdueItem.fromSppt(
    ListSpptRow row,
  ) {
    return OverdueItem(
      sppt: row,
    );
  }
}