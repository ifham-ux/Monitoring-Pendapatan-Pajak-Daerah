import 'package:monitoring_pendapatan_pajak_daerah/Models/models.dart';

class OverdueItem {
  final ListSpptRow sppt;

  OverdueItem({
    required this.sppt,
  });

  factory OverdueItem.fromSppt(ListSpptRow row) {
    return OverdueItem(sppt: row);
  }

  /// Serialisasi ke Map untuk disimpan ke cache Hive.
  Map<String, dynamic> toJson() => {'sppt': sppt.toJson()};

  /// Deserialisasi dari Map cache Hive.
  factory OverdueItem.fromJson(Map<String, dynamic> json) {
    return OverdueItem(
      sppt: ListSpptRow.fromJson(json['sppt'] as Map<String, dynamic>),
    );
  }
}