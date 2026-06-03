import 'dart:convert';

ListKelurahan listKelurahanFromJson(String str) => ListKelurahan.fromJson(json.decode(str));

String listKelurahanToJson(ListKelurahan data) => json.encode(data.toJson());

class ListKelurahan {
    List<ListKelurahanJson> json;

    ListKelurahan({
        required this.json,
    });

    factory ListKelurahan.fromJson(Map<String, dynamic> json) => ListKelurahan(
        json: List<ListKelurahanJson>.from(json["json"].map((x) => ListKelurahanJson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "json": List<dynamic>.from(json.map((x) => x.toJson())),
    };
}

class ListKelurahanJson {
    String kdPropinsi;
    String kdDati2;
    String kdKecamatan;
    String kdKelurahan;
    String kdSektor;
    String nmKelurahan;
    int noKelurahan;
    dynamic kdPosKelurahan;

    ListKelurahanJson({
        required this.kdPropinsi,
        required this.kdDati2,
        required this.kdKecamatan,
        required this.kdKelurahan,
        required this.kdSektor,
        required this.nmKelurahan,
        required this.noKelurahan,
        required this.kdPosKelurahan,
    });

    factory ListKelurahanJson.fromJson(Map<String, dynamic> json) => ListKelurahanJson(
        kdPropinsi: json["kdPropinsi"]?.toString() ?? "",
        kdDati2: json["kdDati2"]?.toString() ?? "",
        kdKecamatan: json["kdKecamatan"]?.toString() ?? "",
        kdKelurahan: json["kdKelurahan"]?.toString() ?? "",
        kdSektor: json["kdSektor"]?.toString() ?? "",
        nmKelurahan: json["nmKelurahan"]?.toString() ?? "",
        noKelurahan: int.tryParse(json["noKelurahan"].toString()) ?? 0,
        kdPosKelurahan: json["kdPosKelurahan"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "kdPropinsi": kdPropinsi,
        "kdDati2": kdDati2,
        "kdKecamatan": kdKecamatan,
        "kdKelurahan": kdKelurahan,
        "kdSektor": kdSektor,
        "nmKelurahan": nmKelurahan,
        "noKelurahan": noKelurahan,
        "kdPosKelurahan": kdPosKelurahan,
    };
}
