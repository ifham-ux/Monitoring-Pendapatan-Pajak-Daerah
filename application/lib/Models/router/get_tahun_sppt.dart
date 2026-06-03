import 'dart:convert';

GetTahunSppt getTahunSpptFromJson(String str) =>
    GetTahunSppt.fromJson(json.decode(str));

String getTahunSpptToJson(GetTahunSppt data) =>
    json.encode(data.toJson());

class GetTahunSppt {

  final GetTahunSpptJson json;
  final List<List<dynamic>> meta;

  GetTahunSppt({
    required this.json,
    required this.meta,
  });

  factory GetTahunSppt.fromJson(Map<String, dynamic> json) =>
      GetTahunSppt(

        json: GetTahunSpptJson.fromJson(
          json["json"] ?? {},
        ),

        meta: json["meta"] == null
            ? []
            : List<List<dynamic>>.from(
                json["meta"].map(
                  (x) => List<dynamic>.from(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "json": json.toJson(),
        "meta": List<dynamic>.from(
          meta.map(
            (x) => List<dynamic>.from(x),
          ),
        ),
      };
}

class GetTahunSpptJson {

  final String kdPropinsi;
  final String kdDati2;
  final String kdKecamatan;
  final String kdKelurahan;
  final String kdBlok;
  final String noUrut;
  final String kdJnsOp;
  final String thnPajakSppt;

  final int siklusSppt;

  final String kdKanwilBank;
  final String kdKppbbBank;
  final String kdBankTunggal;
  final String kdBankPersepsi;
  final String kdTp;

  final String nmWpSppt;
  final String jlnWpSppt;

  final dynamic blokKavNoWpSppt;
  final dynamic rwWpSppt;
  final dynamic rtWpSppt;
  final dynamic kelurahanWpSppt;
  final dynamic kotaWpSppt;
  final dynamic kdPosWpSppt;
  final dynamic npwpSppt;
  final dynamic noPersilSppt;
  final dynamic kdKlsTanah;
  final dynamic thnAwalKlsTanah;
  final dynamic kdKlsBng;
  final dynamic thnAwalKlsBng;
  final dynamic tglJatuhTempoSppt;

  final int luasBumiSppt;
  final int luasBngSppt;
  final int njopBumiSppt;
  final int njopBngSppt;
  final int njopSppt;
  final int njoptkpSppt;
  final int njkpSppt;
  final int pbbTerhutangSppt;
  final int faktorPengurangSppt;
  final int pbbYgHarusDibayarSppt;

  final int statusPembayaranSppt;
  final int statusTagihanSppt;
  final int statusCetakSppt;

  final String statusPembatalan;

  final DateTime tglTerbitSppt;
  final DateTime tglCetakSppt;

  final dynamic nipPencetakSppt;

  GetTahunSpptJson({
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,
    required this.thnPajakSppt,
    required this.siklusSppt,
    required this.kdKanwilBank,
    required this.kdKppbbBank,
    required this.kdBankTunggal,
    required this.kdBankPersepsi,
    required this.kdTp,
    required this.nmWpSppt,
    required this.jlnWpSppt,
    required this.blokKavNoWpSppt,
    required this.rwWpSppt,
    required this.rtWpSppt,
    required this.kelurahanWpSppt,
    required this.kotaWpSppt,
    required this.kdPosWpSppt,
    required this.npwpSppt,
    required this.noPersilSppt,
    required this.kdKlsTanah,
    required this.thnAwalKlsTanah,
    required this.kdKlsBng,
    required this.thnAwalKlsBng,
    required this.tglJatuhTempoSppt,
    required this.luasBumiSppt,
    required this.luasBngSppt,
    required this.njopBumiSppt,
    required this.njopBngSppt,
    required this.njopSppt,
    required this.njoptkpSppt,
    required this.njkpSppt,
    required this.pbbTerhutangSppt,
    required this.faktorPengurangSppt,
    required this.pbbYgHarusDibayarSppt,
    required this.statusPembayaranSppt,
    required this.statusTagihanSppt,
    required this.statusCetakSppt,
    required this.statusPembatalan,
    required this.tglTerbitSppt,
    required this.tglCetakSppt,
    required this.nipPencetakSppt,
  });

  factory GetTahunSpptJson.fromJson(Map<String, dynamic> json) =>
      GetTahunSpptJson(

        kdPropinsi: json["kdPropinsi"]?.toString() ?? '',
        kdDati2: json["kdDati2"]?.toString() ?? '',
        kdKecamatan: json["kdKecamatan"]?.toString() ?? '',
        kdKelurahan: json["kdKelurahan"]?.toString() ?? '',
        kdBlok: json["kdBlok"]?.toString() ?? '',
        noUrut: json["noUrut"]?.toString() ?? '',
        kdJnsOp: json["kdJnsOp"]?.toString() ?? '',
        thnPajakSppt: json["thnPajakSppt"]?.toString() ?? '',

        siklusSppt: json["siklusSppt"] ?? 0,

        kdKanwilBank: json["kdKanwilBank"]?.toString() ?? '',
        kdKppbbBank: json["kdKppbbBank"]?.toString() ?? '',
        kdBankTunggal: json["kdBankTunggal"]?.toString() ?? '',
        kdBankPersepsi: json["kdBankPersepsi"]?.toString() ?? '',
        kdTp: json["kdTp"]?.toString() ?? '',

        nmWpSppt: json["nmWpSppt"]?.toString() ?? '',
        jlnWpSppt: json["jlnWpSppt"]?.toString() ?? '',

        blokKavNoWpSppt: json["blokKavNoWpSppt"],
        rwWpSppt: json["rwWpSppt"],
        rtWpSppt: json["rtWpSppt"],
        kelurahanWpSppt: json["kelurahanWpSppt"],
        kotaWpSppt: json["kotaWpSppt"],
        kdPosWpSppt: json["kdPosWpSppt"],
        npwpSppt: json["npwpSppt"],
        noPersilSppt: json["noPersilSppt"],
        kdKlsTanah: json["kdKlsTanah"],
        thnAwalKlsTanah: json["thnAwalKlsTanah"],
        kdKlsBng: json["kdKlsBng"],
        thnAwalKlsBng: json["thnAwalKlsBng"],
        tglJatuhTempoSppt: json["tglJatuhTempoSppt"],

        luasBumiSppt: json["luasBumiSppt"] ?? 0,
        luasBngSppt: json["luasBngSppt"] ?? 0,
        njopBumiSppt: json["njopBumiSppt"] ?? 0,
        njopBngSppt: json["njopBngSppt"] ?? 0,
        njopSppt: json["njopSppt"] ?? 0,
        njoptkpSppt: json["njoptkpSppt"] ?? 0,
        njkpSppt: json["njkpSppt"] ?? 0,
        pbbTerhutangSppt: json["pbbTerhutangSppt"] ?? 0,
        faktorPengurangSppt: json["faktorPengurangSppt"] ?? 0,
        pbbYgHarusDibayarSppt:
            json["pbbYgHarusDibayarSppt"] ?? 0,

        statusPembayaranSppt:
            json["statusPembayaranSppt"] ?? 0,

        statusTagihanSppt:
            json["statusTagihanSppt"] ?? 0,

        statusCetakSppt:
            json["statusCetakSppt"] ?? 0,

        statusPembatalan:
            json["statusPembatalan"]?.toString() ?? '',

        tglTerbitSppt:
            DateTime.tryParse(
                  json["tglTerbitSppt"]?.toString() ?? '',
                ) ??
                DateTime.now(),

        tglCetakSppt:
            DateTime.tryParse(
                  json["tglCetakSppt"]?.toString() ?? '',
                ) ??
                DateTime.now(),

        nipPencetakSppt:
            json["nipPencetakSppt"],
      );

  Map<String, dynamic> toJson() => {

        "kdPropinsi": kdPropinsi,
        "kdDati2": kdDati2,
        "kdKecamatan": kdKecamatan,
        "kdKelurahan": kdKelurahan,
        "kdBlok": kdBlok,
        "noUrut": noUrut,
        "kdJnsOp": kdJnsOp,
        "thnPajakSppt": thnPajakSppt,

        "siklusSppt": siklusSppt,

        "kdKanwilBank": kdKanwilBank,
        "kdKppbbBank": kdKppbbBank,
        "kdBankTunggal": kdBankTunggal,
        "kdBankPersepsi": kdBankPersepsi,
        "kdTp": kdTp,

        "nmWpSppt": nmWpSppt,
        "jlnWpSppt": jlnWpSppt,

        "blokKavNoWpSppt": blokKavNoWpSppt,
        "rwWpSppt": rwWpSppt,
        "rtWpSppt": rtWpSppt,
        "kelurahanWpSppt": kelurahanWpSppt,
        "kotaWpSppt": kotaWpSppt,
        "kdPosWpSppt": kdPosWpSppt,
        "npwpSppt": npwpSppt,
        "noPersilSppt": noPersilSppt,
        "kdKlsTanah": kdKlsTanah,
        "thnAwalKlsTanah": thnAwalKlsTanah,
        "kdKlsBng": kdKlsBng,
        "thnAwalKlsBng": thnAwalKlsBng,
        "tglJatuhTempoSppt": tglJatuhTempoSppt,

        "luasBumiSppt": luasBumiSppt,
        "luasBngSppt": luasBngSppt,
        "njopBumiSppt": njopBumiSppt,
        "njopBngSppt": njopBngSppt,
        "njopSppt": njopSppt,
        "njoptkpSppt": njoptkpSppt,
        "njkpSppt": njkpSppt,
        "pbbTerhutangSppt": pbbTerhutangSppt,
        "faktorPengurangSppt": faktorPengurangSppt,
        "pbbYgHarusDibayarSppt":
            pbbYgHarusDibayarSppt,

        "statusPembayaranSppt":
            statusPembayaranSppt,

        "statusTagihanSppt":
            statusTagihanSppt,

        "statusCetakSppt":
            statusCetakSppt,

        "statusPembatalan":
            statusPembatalan,

        "tglTerbitSppt":
            tglTerbitSppt.toIso8601String(),

        "tglCetakSppt":
            tglCetakSppt.toIso8601String(),

        "nipPencetakSppt":
            nipPencetakSppt,
      };
}