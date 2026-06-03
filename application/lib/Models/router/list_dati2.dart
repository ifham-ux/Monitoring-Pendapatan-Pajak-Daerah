import 'dart:convert';

ListDati2 listDati2FromJson(String str) => ListDati2.fromJson(json.decode(str));

String listDati2ToJson(ListDati2 data) => json.encode(data.toJson());

class ListDati2 {
    List<ListDati2Json> json;

    ListDati2({
        required this.json,
    });

    factory ListDati2.fromJson(Map<String, dynamic> json) => ListDati2(
        json: List<ListDati2Json>.from(json["json"].map((x) => ListDati2Json.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "json": List<dynamic>.from(json.map((x) => x.toJson())),
    };
}

class ListDati2Json {
    String kdPropinsi;
    String kdDati2;
    String nmDati2;

    ListDati2Json({
        required this.kdPropinsi,
        required this.kdDati2,
        required this.nmDati2,
    });

    factory ListDati2Json.fromJson(Map<String, dynamic> json) => ListDati2Json(
        kdPropinsi: json["kdPropinsi"]?.toString() ?? "",
        kdDati2: json["kdDati2"]?.toString() ?? "",
        nmDati2: json["nmDati2"]?.toString() ?? "",
    );

    Map<String, dynamic> toJson() => {
        "kdPropinsi": kdPropinsi,
        "kdDati2": kdDati2,
        "nmDati2": nmDati2,
    };
}
