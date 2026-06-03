import 'dart:convert';

ListSppt listSpptFromJson(String str) =>
    ListSppt.fromJson(json.decode(str));

String listSpptToJson(ListSppt data) =>
    json.encode(data.toJson());

class ListSppt {
  ListSpptJson json;

  ListSppt({
    required this.json,
  });

  factory ListSppt.fromJson(
    Map<String, dynamic> json,
  ) =>
      ListSppt(
        json: ListSpptJson.fromJson(
          json["json"] ?? {},
        ),
      );

  Map<String, dynamic> toJson() => {
        "json": json.toJson(),
      };
}

class ListSpptJson {
  List<ListSpptRow> rows;
  int total;

  ListSpptJson({
    required this.rows,
    required this.total,
  });

  factory ListSpptJson.fromJson(
    Map<String, dynamic> json,
  ) =>
      ListSpptJson(
        rows:
            (json["rows"] as List<dynamic>? ?? [])
                .map(
                  (x) => ListSpptRow.fromJson(
                    x as Map<String, dynamic>,
                  ),
                )
                .toList(),

        total:
            int.tryParse(
              json["total"].toString(),
            ) ??
            0,
      );

  Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(
          rows.map(
            (x) => x.toJson(),
          ),
        ),
        "total": total,
      };
}

class ListSpptRow {
  String kdPropinsi;
  String kdDati2;
  String kdKecamatan;
  String kdKelurahan;
  String kdBlok;
  String noUrut;
  String kdJnsOp;
  String thnPajakSppt;

  int siklusSppt;

  String kdKanwilBank;
  String kdKppbbBank;
  String kdBankTunggal;
  String kdBankPersepsi;
  String kdTp;

  String nmWpSppt;
  String jlnWpSppt;
  dynamic blokKavNoWpSppt;
  dynamic rwWpSppt;
  dynamic rtWpSppt;
  dynamic kelurahanWpSppt;
  dynamic kotaWpSppt;
  dynamic kdPosWpSppt;
  dynamic npwpSppt;
  dynamic noPersilSppt;
  dynamic kdKlsTanah;
  dynamic thnAwalKlsTanah;
  dynamic kdKlsBng;
  dynamic thnAwalKlsBng;
  dynamic tglJatuhTempoSppt;

  int luasBumiSppt;
  int luasBngSppt;

  int njopBumiSppt;
  int njopBngSppt;
  int njopSppt;
  int njoptkpSppt;
  int njkpSppt;

  int pbbTerhutangSppt;
  int faktorPengurangSppt;
  int pbbYgHarusDibayarSppt;

  int statusPembayaranSppt;
  int statusTagihanSppt;
  int statusCetakSppt;

  String statusPembatalan;

  DateTime? tglTerbitSppt;
  DateTime? tglCetakSppt;

  dynamic nipPencetakSppt;

  ListSpptRow({
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

  factory ListSpptRow.fromJson(
    Map<String, dynamic> json,
  ) =>
      ListSpptRow(
        kdPropinsi:
            json["kdPropinsi"]?.toString() ?? "",

        kdDati2:
            json["kdDati2"]?.toString() ?? "",

        kdKecamatan:
            json["kdKecamatan"]?.toString() ?? "",

        kdKelurahan:
            json["kdKelurahan"]?.toString() ?? "",

        kdBlok:
            json["kdBlok"]?.toString() ?? "",

        noUrut:
            json["noUrut"]?.toString() ?? "",

        kdJnsOp:
            json["kdJnsOp"]?.toString() ?? "",

        thnPajakSppt:
            json["thnPajakSppt"]?.toString() ?? "",

        siklusSppt:
            int.tryParse(
              json["siklusSppt"].toString(),
            ) ??
            0,

        kdKanwilBank:
            json["kdKanwilBank"]?.toString() ?? "",

        kdKppbbBank:
            json["kdKppbbBank"]?.toString() ?? "",

        kdBankTunggal:
            json["kdBankTunggal"]?.toString() ?? "",

        kdBankPersepsi:
            json["kdBankPersepsi"]?.toString() ?? "",

        kdTp:
            json["kdTp"]?.toString() ?? "",

        nmWpSppt:
            json["nmWpSppt"]?.toString() ?? "",

        jlnWpSppt:
            json["jlnWpSppt"]?.toString() ?? "",

        blokKavNoWpSppt:
            json["blokKavNoWpSppt"],

        rwWpSppt:
            json["rwWpSppt"],

        rtWpSppt:
            json["rtWpSppt"],

        kelurahanWpSppt:
            json["kelurahanWpSppt"],

        kotaWpSppt:
            json["kotaWpSppt"],

        kdPosWpSppt:
            json["kdPosWpSppt"],

        npwpSppt:
            json["npwpSppt"],

        noPersilSppt:
            json["noPersilSppt"],

        kdKlsTanah:
            json["kdKlsTanah"],

        thnAwalKlsTanah:
            json["thnAwalKlsTanah"],

        kdKlsBng:
            json["kdKlsBng"],

        thnAwalKlsBng:
            json["thnAwalKlsBng"],

        tglJatuhTempoSppt:
            json["tglJatuhTempoSppt"],

        luasBumiSppt:
            int.tryParse(
              json["luasBumiSppt"].toString(),
            ) ??
            0,

        luasBngSppt:
            int.tryParse(
              json["luasBngSppt"].toString(),
            ) ??
            0,

        njopBumiSppt:
            int.tryParse(
              json["njopBumiSppt"].toString(),
            ) ??
            0,

        njopBngSppt:
            int.tryParse(
              json["njopBngSppt"].toString(),
            ) ??
            0,

        njopSppt:
            int.tryParse(
              json["njopSppt"].toString(),
            ) ??
            0,

        njoptkpSppt:
            int.tryParse(
              json["njoptkpSppt"].toString(),
            ) ??
            0,

        njkpSppt:
            int.tryParse(
              json["njkpSppt"].toString(),
            ) ??
            0,

        pbbTerhutangSppt:
            int.tryParse(
              json["pbbTerhutangSppt"].toString(),
            ) ??
            0,

        faktorPengurangSppt:
            int.tryParse(
              json["faktorPengurangSppt"].toString(),
            ) ??
            0,

        pbbYgHarusDibayarSppt:
            int.tryParse(
              json["pbbYgHarusDibayarSppt"].toString(),
            ) ??
            0,

        statusPembayaranSppt:
            int.tryParse(
              json["statusPembayaranSppt"].toString(),
            ) ??
            0,

        statusTagihanSppt:
            int.tryParse(
              json["statusTagihanSppt"].toString(),
            ) ??
            0,

        statusCetakSppt:
            int.tryParse(
              json["statusCetakSppt"].toString(),
            ) ??
            0,

        statusPembatalan:
            json["statusPembatalan"]?.toString() ??
            "",

        tglTerbitSppt:
            json["tglTerbitSppt"] != null
                ? DateTime.tryParse(
                    json["tglTerbitSppt"]
                        .toString(),
                  )
                : null,

        tglCetakSppt:
            json["tglCetakSppt"] != null
                ? DateTime.tryParse(
                    json["tglCetakSppt"]
                        .toString(),
                  )
                : null,

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
        "pbbTerhutangSppt":
            pbbTerhutangSppt,
        "faktorPengurangSppt":
            faktorPengurangSppt,
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
            tglTerbitSppt
                ?.toIso8601String(),
        "tglCetakSppt":
            tglCetakSppt
                ?.toIso8601String(),
        "nipPencetakSppt":
            nipPencetakSppt,
      };
}