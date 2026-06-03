import 'dart:convert';

ListDetails listDetailsFromJson(String str) =>
    ListDetails.fromJson(json.decode(str));

String listDetailsToJson(ListDetails data) =>
    json.encode(data.toJson());

class ListDetails {
  ListDetailsJson json;

  ListDetails({
    required this.json,
  });

  factory ListDetails.fromJson(Map<String, dynamic> json) =>
      ListDetails(
        json: ListDetailsJson.fromJson(json["json"]),
      );

  Map<String, dynamic> toJson() => {
        "json": json.toJson(),
      };
}

class ListDetailsJson {
  List<ListDetailsRow> rows;
  int total;

  ListDetailsJson({
    required this.rows,
    required this.total,
  });

  factory ListDetailsJson.fromJson(Map<String, dynamic> json) =>
      ListDetailsJson(
        rows: (json["rows"] as List<dynamic>? ?? [])
            .map((x) => ListDetailsRow.fromJson(x))
            .toList(),

        total: int.tryParse(json["total"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(
          rows.map((x) => x.toJson()),
        ),
        "total": total,
      };
}

class ListDetailsRow {
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
  int njopBumi;
  String totalLuasBng;
  String totalNilaiBng;

  ListDetailsRow({
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
    required this.totalLuasBng,
    required this.totalNilaiBng,
  });

  factory ListDetailsRow.fromJson(Map<String, dynamic> json) =>
      ListDetailsRow(
        kdPropinsi: json["kdPropinsi"]?.toString() ?? "",
        kdDati2: json["kdDati2"]?.toString() ?? "",
        kdKecamatan: json["kdKecamatan"]?.toString() ?? "",
        kdKelurahan: json["kdKelurahan"]?.toString() ?? "",
        kdBlok: json["kdBlok"]?.toString() ?? "",
        noUrut: json["noUrut"]?.toString() ?? "",
        kdJnsOp: json["kdJnsOp"]?.toString() ?? "",
        nmWpSppt: json["nmWpSppt"]?.toString() ?? "",
        jalanOp: json["jalanOp"]?.toString() ?? "",

        luasBumi:
            int.tryParse(json["luasBumi"].toString()) ?? 0,

        njopBumi:
            int.tryParse(json["njopBumi"].toString()) ?? 0,

        totalLuasBng:
            json["totalLuasBng"]?.toString() ?? "",

        totalNilaiBng:
            json["totalNilaiBng"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "kdPropinsi": kdPropinsi,
        "kdDati2": kdDati2,
        "kdKecamatan": kdKecamatan,
        "kdKelurahan": kdKelurahan,
        "kdBlok": kdBlok,
        "noUrut": noUrut,
        "kdJnsOp": kdJnsOp,
        "nmWpSppt": nmWpSppt,
        "jalanOp": jalanOp,
        "luasBumi": luasBumi,
        "njopBumi": njopBumi,
        "totalLuasBng": totalLuasBng,
        "totalNilaiBng": totalNilaiBng,
      };
}