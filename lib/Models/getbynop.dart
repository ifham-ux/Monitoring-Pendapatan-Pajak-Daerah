class subjekpajak {

  String subjekPajakId;
  String nmWp;
  String jalanWp;
  String blokKavNoWp;
  String rwWp;
  String rtWp;
  String kelurahanWp;
  String kotaWp;
  String kdPosWp;
  String telpWp;
  String npwp;
  String statusPekerjaanWp;
  String emailWp;

  subjekpajak({

    required this.subjekPajakId,
    required this.nmWp,
    required this.jalanWp,
    required this.blokKavNoWp,
    required this.rwWp,
    required this.rtWp,
    required this.kelurahanWp,
    required this.kotaWp,
    required this.kdPosWp,
    required this.telpWp,
    required this.npwp,
    required this.statusPekerjaanWp,
    required this.emailWp,
  });

  factory subjekpajak.fromJson(
    Map<String, dynamic> json,
  ) {

    return subjekpajak(

      subjekPajakId:
          json['subjekPajakId']?.toString() ?? '',

      nmWp:
          json['nmWp']?.toString() ?? '',

      jalanWp:
          json['jalanWp']?.toString() ?? '',

      blokKavNoWp:
          json['blokKavNoWp']?.toString() ?? '',

      rwWp:
          json['rwWp']?.toString() ?? '',

      rtWp:
          json['rtWp']?.toString() ?? '',

      kelurahanWp:
          json['kelurahanWp']?.toString() ?? '',

      kotaWp:
          json['kotaWp']?.toString() ?? '',

      kdPosWp:
          json['kdPosWp']?.toString() ?? '',

      telpWp:
          json['telpWp']?.toString() ?? '',

      npwp:
          json['npwp']?.toString() ?? '',

      statusPekerjaanWp:
          json['statusPekerjaanWp']?.toString() ?? '',

      emailWp:
          json['emailWp']?.toString() ?? '',
    );
  }
}

class getbynop {

  String kdPropinsi;
  String kdDati2;
  String kdKecamatan;
  String kdKelurahan;
  String kdBlok;
  String noUrut;
  String kdJnsOp;

  String jalanOp;

  String tglPendataanOp;
  String nmPendataanOp;
  String nipPendata;

  String tglPemeriksaanOp;
  String nmPemeriksaanOp;
  String nipPemeriksaOp;

  // FIX #1: Changed from String to int for numeric fields
  int luasBumi;
  int njopBumi;
  int totalLuasBng;
  int totalNilaiBng;

  // FIX #2: Made nullable (removed required)
  subjekpajak? subjekPajak;

  getbynop({

    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,

    required this.jalanOp,

    required this.tglPendataanOp,
    required this.nmPendataanOp,
    required this.nipPendata,

    required this.tglPemeriksaanOp,
    required this.nmPemeriksaanOp,
    required this.nipPemeriksaOp,

    required this.luasBumi,
    required this.njopBumi,
    required this.totalLuasBng,
    required this.totalNilaiBng,

    // FIX #2: Removed required
    this.subjekPajak,
  });

  factory getbynop.fromJson(
    Map<String, dynamic> json,
  ) {

    return getbynop(

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

      jalanOp:
          json['jalanOp']?.toString() ?? '',

      tglPendataanOp:
          json['tglPendataanOp']?.toString() ?? '',

      nmPendataanOp:
          json['nmPendataanOp']?.toString() ?? '',

      nipPendata:
          json['nipPendata']?.toString() ?? '',

      tglPemeriksaanOp:
          json['tglPemeriksaanOp']?.toString() ?? '',

      nmPemeriksaanOp:
          json['nmPemeriksaanOp']?.toString() ?? '',

      nipPemeriksaOp:
          json['nipPemeriksaOp']?.toString() ?? '',

      // FIX #1: Parse as int instead of String
      luasBumi:
          (json['luasBumi'] as int?) ?? 0,

      njopBumi:
          (json['njopBumi'] as int?) ?? 0,

      totalLuasBng:
          (json['totalLuasBng'] as int?) ?? 0,

      totalNilaiBng:
          (json['totalNilaiBng'] as int?) ?? 0,

      subjekPajak:
          json['subjekPajak'] != null

              ? subjekpajak.fromJson(
                  json['subjekPajak'],
                )

              : null,
    );
  }
}