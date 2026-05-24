class listdetails {

  String kdPropinsi;
  String kdDati2;
  String kdKecamatan;
  String kdKelurahan;
  String kdBlok;
  String noUrut;
  String kdJnsOp;

  String nmWpSppt;
  String jalanOp;

  int luasBumi;
  double njopBumi;

  listdetails({

    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,

    required this.nmWpSppt,
    required this.jalanOp,

    required this.luasBumi,
    required this.njopBumi,
  });

  factory listdetails.fromJson(
    Map<String, dynamic> json,
  ) {

    return listdetails(

      kdPropinsi:
          json['kdPropinsi']?.toString() ?? '',

      kdDati2:
          json['kdDati2']?.toString() ?? '',

      kdKecamatan:
          json['kdKecamatan']?.toString() ?? '',

      kdKelurahan:
          json['kdKelurahan']?.toString() ?? '',

      kdBlok:
          json['kdBlok']?.toString() ?? '',

      noUrut:
          json['noUrut']?.toString() ?? '',

      kdJnsOp:
          json['kdJnsOp']?.toString() ?? '',

      nmWpSppt:
          json['nmWpSppt']?.toString() ?? '',

      jalanOp:
          json['jalanOp']?.toString() ?? '',

      luasBumi:
          int.tryParse(
            json['luasBumi']?.toString() ?? '0',
          ) ?? 0,

      njopBumi:
          double.tryParse(
            json['njopBumi']?.toString() ?? '0',
          ) ?? 0,
    );
  }
}