import 'dart:convert';

ListKecamatan listKecamatanFromJson(String str) => ListKecamatan.fromJson(json.decode(str));

String listKecamatanToJson(ListKecamatan data) => json.encode(data.toJson());

class ListKecamatan {
    List<ListKecamatanJson> json;

    ListKecamatan({
        required this.json,
    });

    factory ListKecamatan.fromJson(Map<String, dynamic> json) => ListKecamatan(
        json: List<ListKecamatanJson>.from(json["json"].map((x) => ListKecamatanJson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "json": List<dynamic>.from(json.map((x) => x.toJson())),
    };
}

class ListKecamatanJson {
    String kdPropinsi;
    String kdDati2;
    String kdKecamatan;
    String nmKecamatan;

    ListKecamatanJson({
        required this.kdPropinsi,
        required this.kdDati2,
        required this.kdKecamatan,
        required this.nmKecamatan,
    });

    factory ListKecamatanJson.fromJson(Map<String, dynamic> json) => ListKecamatanJson(
        kdPropinsi: json["kdPropinsi"]?.toString() ?? "",
        kdDati2: json["kdDati2"]?.toString() ?? "",
        kdKecamatan: json["kdKecamatan"]?.toString() ?? "",
        nmKecamatan: json["nmKecamatan"]?.toString() ?? "",
    );

    Map<String, dynamic> toJson() => {
        "kdPropinsi": kdPropinsi,
        "kdDati2": kdDati2,
        "kdKecamatan": kdKecamatan,
        "nmKecamatan": nmKecamatan,
    };
}
