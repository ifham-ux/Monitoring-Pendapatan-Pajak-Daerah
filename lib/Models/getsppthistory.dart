import 'package:intl/intl.dart';

class getsppthistory {
  String kdPropinsi;
  String kdDati2;
  String kdKecamatan;
  String kdKelurahan;
  String kdBlok;
  String noUrut;
  String kdJnsOp;
  int thnPajakSppt;

  String nmWpSppt;
  String jlnWpSppt;

  int luasBumiSppt;
  double njopBumiSppt;

  int luasBngSppt;
  double njopBngSppt;

  double njopSppt;
  double njoptkpSppt;
  double njkpSppt;
  double pbbYangHarusDibayarSppt;

  String tglTerbitSppt;
  String tglCetakSppt;
  String statusPembayaran;

  var thnSpptPajak;

  getsppthistory({
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,
    required this.thnPajakSppt,

    required this.nmWpSppt,
    required this.jlnWpSppt,

    required this.luasBumiSppt,
    required this.njopBumiSppt,

    required this.luasBngSppt,
    required this.njopBngSppt,

    required this.njopSppt,
    required this.njoptkpSppt,
    required this.njkpSppt,
    required this.pbbYangHarusDibayarSppt,

    required this.tglTerbitSppt,
    required this.tglCetakSppt,
    required this.statusPembayaran,


  });

  factory getsppthistory.fromJson(Map<String, dynamic> json) {
    final dateStr = (json['tglTerbitSppt'] ?? '').toString();
    final date = dateStr.isEmpty ? DateTime.now() : DateTime.parse(dateStr);
    final tahun = int.tryParse(json['thnPajakSppt']?.toString() ?? '') ?? 0;

    return getsppthistory(
      kdPropinsi: json['kdPropinsi']?.toString() ?? '',
      kdDati2: json['kdDati2']?.toString() ?? '',
      kdKecamatan: json['kdKecamatan']?.toString() ?? '',
      kdKelurahan: json['kdKelurahan']?.toString() ?? '',
      kdBlok: json['kdBlok']?.toString() ?? '',
      noUrut: json['noUrut']?.toString() ?? '',
      kdJnsOp: json['kdJnsOp']?.toString() ?? '',
      thnPajakSppt: tahun,

      nmWpSppt: json['nmWpSppt']?.toString() ?? '',
      jlnWpSppt: json['jlnWpSppt']?.toString() ?? '',

      luasBumiSppt: json['luasBumiSppt'] ?? 0,
      njopBumiSppt:
          (json['njopBumiSppt'] as num?)?.toDouble() ?? 0.0,

      luasBngSppt: json['luasBngSppt'] ?? 0,
      njopBngSppt:
          (json['njopBngSppt'] as num?)?.toDouble() ?? 0.0,

      njopSppt:
          (json['njopSppt'] as num?)?.toDouble() ?? 0.0,

      njoptkpSppt:
          (json['njoptkpSppt'] as num?)?.toDouble() ?? 0.0,

      njkpSppt:
          (json['njkpSppt'] as num?)?.toDouble() ?? 0.0,

      pbbYangHarusDibayarSppt: (json['pbbYangHarusDibayarSppt'] as num?)?.toDouble() ?? 0.0,

      tglTerbitSppt: DateFormat('MMM').format(date),

      tglCetakSppt:
          json['tglCetakSppt']?.toString() ?? '',

      statusPembayaran:
          json['statusPembayaran']?.toString() ?? '',
    );
  }

}