import 'package:intl/intl.dart';

class listsppt {
  String kdPropinsi;
  String kdDati2;
  String kdKecamatan;
  String kdKelurahan;
  String kdBlok;
  String noUrut;
  String kdJnsOp;
  String? statusPembayaran;


  String thnPajakSppt;
  int pbbYangHarusDibayarSppt;
  String tglTerbitSppt;

  listsppt({
    required this.thnPajakSppt,
    required this.pbbYangHarusDibayarSppt,
    required this.tglTerbitSppt,
    required this.statusPembayaran,

    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,

  });

  factory listsppt.fromJson(Map<String, dynamic> json) {
    final dateStr = (json['tglTerbitSppt'] ?? '').toString();
    final date = dateStr.isEmpty ? DateTime.now() : DateTime.parse(dateStr);

    final pbb = json['pbbYangHarusDibayarSppt'];
    final pbbInt = (pbb == null) ? 0 : (pbb as num).toInt();

    return listsppt(
      pbbYangHarusDibayarSppt: pbbInt,
      tglTerbitSppt: DateFormat('MMM').format(date),
      thnPajakSppt: json['thnPajakSppt']?.toString() ?? '',

      statusPembayaran: json['statusPembayaranSppt']?.toString() ?? '',
      kdPropinsi: json['kdPropinsi']?.toString() ?? '',
      kdDati2: json['kdDati2']?.toString() ?? '',
      kdKecamatan: json['kdKecamatan']?.toString() ?? '',
      kdKelurahan: json['kdKelurahan']?.toString() ?? '',
      kdBlok: json['kdBlok']?.toString() ?? '',
      noUrut: json['noUrut']?.toString() ?? '',
      kdJnsOp: json['kdJnsOp']?.toString() ?? '',
    );
  }

}