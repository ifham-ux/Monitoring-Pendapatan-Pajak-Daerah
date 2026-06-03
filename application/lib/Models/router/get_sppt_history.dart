import 'dart:convert';

GetSpptHistory getSpptHistoryFromJson(String str) =>
    GetSpptHistory.fromJson(json.decode(str));

String getSpptHistoryToJson(GetSpptHistory data) =>
    json.encode(data.toJson());

class GetSpptHistory {

  final List<GetSpptHistoryJson> json;
  final List<List<dynamic>> meta;

  GetSpptHistory({
    required this.json,
    required this.meta,
  });

  factory GetSpptHistory.fromJson(
    Map<String, dynamic> json,
  ) => GetSpptHistory(

        json: json["json"] == null
            ? []
            : List<GetSpptHistoryJson>.from(
                json["json"].map(
                  (x) => GetSpptHistoryJson.fromJson(x),
                ),
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
        "json": List<dynamic>.from(
          json.map(
            (x) => x.toJson(),
          ),
        ),

        "meta": List<dynamic>.from(
          meta.map(
            (x) => List<dynamic>.from(x),
          ),
        ),
      };
}

class GetSpptHistoryJson {

  final String thnPajakSppt;
  final String nmWpSppt;

  final int luasBumi;
  final int luasBng;

  final int njopBumi;
  final int njopBng;
  final int njopSppt;
  final int njoptkpSppt;
  final int njkpSppt;

  final int pbbHarusDibayar;
  final int statusPembayaran;

  final DateTime tglTerbit;

  final dynamic tglJatuhTempoSppt;

  GetSpptHistoryJson({
    required this.thnPajakSppt,
    required this.nmWpSppt,
    required this.luasBumi,
    required this.luasBng,
    required this.njopBumi,
    required this.njopBng,
    required this.njopSppt,
    required this.njoptkpSppt,
    required this.njkpSppt,
    required this.pbbHarusDibayar,
    required this.statusPembayaran,
    required this.tglTerbit,
    required this.tglJatuhTempoSppt,
  });

  factory GetSpptHistoryJson.fromJson(
    Map<String, dynamic> json,
  ) => GetSpptHistoryJson(

        thnPajakSppt:
            json["thnPajakSppt"]?.toString() ?? '',

        nmWpSppt:
            json["nmWpSppt"]?.toString() ?? '',

        luasBumi:
            json["luasBumi"] ?? 0,

        luasBng:
            json["luasBng"] ?? 0,

        njopBumi:
            json["njopBumi"] ?? 0,

        njopBng:
            json["njopBng"] ?? 0,

        njopSppt:
            json["njopSppt"] ?? 0,

        njoptkpSppt:
            json["njoptkpSppt"] ?? 0,

        njkpSppt:
            json["njkpSppt"] ?? 0,

        pbbHarusDibayar:
            json["pbbHarusDibayar"] ?? 0,

        statusPembayaran:
            json["statusPembayaran"] ?? 0,

        tglTerbit:
            DateTime.tryParse(
                  json["tglTerbit"]?.toString() ?? '',
                ) ??
                DateTime.now(),

        tglJatuhTempoSppt:
            json["tglJatuhTempoSppt"],
      );

  Map<String, dynamic> toJson() => {

        "thnPajakSppt":
            thnPajakSppt,

        "nmWpSppt":
            nmWpSppt,

        "luasBumi":
            luasBumi,

        "luasBng":
            luasBng,

        "njopBumi":
            njopBumi,

        "njopBng":
            njopBng,

        "njopSppt":
            njopSppt,

        "njoptkpSppt":
            njoptkpSppt,

        "njkpSppt":
            njkpSppt,

        "pbbHarusDibayar":
            pbbHarusDibayar,

        "statusPembayaran":
            statusPembayaran,

        "tglTerbit":
            tglTerbit.toIso8601String(),

        "tglJatuhTempoSppt":
            tglJatuhTempoSppt,
      };
}