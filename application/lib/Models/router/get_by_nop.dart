import 'dart:convert';

GetByNop getByNopFromJson(String str) =>
    GetByNop.fromJson(json.decode(str));

String getByNopToJson(GetByNop data) =>
    json.encode(data.toJson());

class GetByNop {
  GetByNopJson json;
  List<List<dynamic>> meta;

  GetByNop({
    required this.json,
    required this.meta,
  });

  factory GetByNop.fromJson(Map<String, dynamic> json) =>
      GetByNop(
        json: GetByNopJson.fromJson(
          json["json"] as Map<String, dynamic>? ?? {},
        ),

        meta: (json["meta"] as List<dynamic>? ?? [])
            .map(
              (x) => List<dynamic>.from(
                (x as List<dynamic>?) ?? [],
              ),
            )
            .toList(),
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

class GetByNopJson {
  String kdPropinsi;
  String kdDati2;
  String kdKecamatan;
  String kdKelurahan;
  String kdBlok;
  String noUrut;
  String kdJnsOp;

  String subjekPajakId;
  String noFormulirSpop;
  String jnsTransaksiOp;

  dynamic kdPropinsiBersama;
  dynamic kdDati2Bersama;
  dynamic kdKecamatanBersama;
  dynamic kdKelurahanBersama;
  dynamic kdBlokBersama;
  dynamic noUrutBersama;
  dynamic kdJnsOpBersama;

  dynamic kdPropinsiAsal;
  dynamic kdDati2Asal;
  dynamic kdKecamatanAsal;
  dynamic kdKelurahanAsal;
  dynamic kdBlokAsal;
  dynamic noUrutAsal;
  dynamic kdJnsOpAsal;

  dynamic noSpptLama;

  String jalanOp;
  String blokKavNoOp;
  String kelurahanOp;
  String rwOp;
  String rtOp;

  String kdStatusWp;

  int luasBumi;

  String kdZnt;
  String jnsBumi;

  int nilaiSistemBumi;

  DateTime? tglPendataanOp;

  String nmPendataanOp;
  String nipPendata;

  DateTime? tglPemeriksaanOp;

  String nmPemeriksaanOp;
  String nipPemeriksaOp;

  dynamic noPersil;

  GetByNopSubjekPajak subjekPajak;

  dynamic anggota;
  dynamic induk;

  GetByNopJson({
    required this.kdPropinsi,
    required this.kdDati2,
    required this.kdKecamatan,
    required this.kdKelurahan,
    required this.kdBlok,
    required this.noUrut,
    required this.kdJnsOp,
    required this.subjekPajakId,
    required this.noFormulirSpop,
    required this.jnsTransaksiOp,
    required this.kdPropinsiBersama,
    required this.kdDati2Bersama,
    required this.kdKecamatanBersama,
    required this.kdKelurahanBersama,
    required this.kdBlokBersama,
    required this.noUrutBersama,
    required this.kdJnsOpBersama,
    required this.kdPropinsiAsal,
    required this.kdDati2Asal,
    required this.kdKecamatanAsal,
    required this.kdKelurahanAsal,
    required this.kdBlokAsal,
    required this.noUrutAsal,
    required this.kdJnsOpAsal,
    required this.noSpptLama,
    required this.jalanOp,
    required this.blokKavNoOp,
    required this.kelurahanOp,
    required this.rwOp,
    required this.rtOp,
    required this.kdStatusWp,
    required this.luasBumi,
    required this.kdZnt,
    required this.jnsBumi,
    required this.nilaiSistemBumi,
    required this.tglPendataanOp,
    required this.nmPendataanOp,
    required this.nipPendata,
    required this.tglPemeriksaanOp,
    required this.nmPemeriksaanOp,
    required this.nipPemeriksaOp,
    required this.noPersil,
    required this.subjekPajak,
    required this.anggota,
    required this.induk,
  });

  factory GetByNopJson.fromJson(Map<String, dynamic> json) =>
      GetByNopJson(
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

        subjekPajakId:
            json["subjekPajakId"]?.toString() ?? "",

        noFormulirSpop:
            json["noFormulirSpop"]?.toString() ?? "",

        jnsTransaksiOp:
            json["jnsTransaksiOp"]?.toString() ?? "",

        kdPropinsiBersama:
            json["kdPropinsiBersama"],

        kdDati2Bersama:
            json["kdDati2Bersama"],

        kdKecamatanBersama:
            json["kdKecamatanBersama"],

        kdKelurahanBersama:
            json["kdKelurahanBersama"],

        kdBlokBersama:
            json["kdBlokBersama"],

        noUrutBersama:
            json["noUrutBersama"],

        kdJnsOpBersama:
            json["kdJnsOpBersama"],

        kdPropinsiAsal:
            json["kdPropinsiAsal"],

        kdDati2Asal:
            json["kdDati2Asal"],

        kdKecamatanAsal:
            json["kdKecamatanAsal"],

        kdKelurahanAsal:
            json["kdKelurahanAsal"],

        kdBlokAsal:
            json["kdBlokAsal"],

        noUrutAsal:
            json["noUrutAsal"],

        kdJnsOpAsal:
            json["kdJnsOpAsal"],

        noSpptLama:
            json["noSpptLama"],

        jalanOp:
            json["jalanOp"]?.toString() ?? "",

        blokKavNoOp:
            json["blokKavNoOp"]?.toString() ?? "",

        kelurahanOp:
            json["kelurahanOp"]?.toString() ?? "",

        rwOp:
            json["rwOp"]?.toString() ?? "",

        rtOp:
            json["rtOp"]?.toString() ?? "",

        kdStatusWp:
            json["kdStatusWp"]?.toString() ?? "",

        luasBumi:
            int.tryParse(
                  json["luasBumi"].toString(),
                ) ??
                0,

        kdZnt:
            json["kdZnt"]?.toString() ?? "",

        jnsBumi:
            json["jnsBumi"]?.toString() ?? "",

        nilaiSistemBumi:
            int.tryParse(
                  json["nilaiSistemBumi"].toString(),
                ) ??
                0,

        tglPendataanOp:
            json["tglPendataanOp"] != null
                ? DateTime.tryParse(
                    json["tglPendataanOp"].toString(),
                  )
                : null,

        nmPendataanOp:
            json["nmPendataanOp"]?.toString() ?? "",

        nipPendata:
            json["nipPendata"]?.toString() ?? "",

        tglPemeriksaanOp:
            json["tglPemeriksaanOp"] != null
                ? DateTime.tryParse(
                    json["tglPemeriksaanOp"].toString(),
                  )
                : null,

        nmPemeriksaanOp:
            json["nmPemeriksaanOp"]?.toString() ?? "",

        nipPemeriksaOp:
            json["nipPemeriksaOp"]?.toString() ?? "",

        noPersil:
            json["noPersil"],

        subjekPajak:
            GetByNopSubjekPajak.fromJson(
              json["subjekPajak"]
                      as Map<String, dynamic>? ??
                  {},
            ),

        anggota:
            json["anggota"],

        induk:
            json["induk"],
      );

  Map<String, dynamic> toJson() => {
        "kdPropinsi": kdPropinsi,
        "kdDati2": kdDati2,
        "kdKecamatan": kdKecamatan,
        "kdKelurahan": kdKelurahan,
        "kdBlok": kdBlok,
        "noUrut": noUrut,
        "kdJnsOp": kdJnsOp,
        "subjekPajakId": subjekPajakId,
        "noFormulirSpop": noFormulirSpop,
        "jnsTransaksiOp": jnsTransaksiOp,
        "kdPropinsiBersama": kdPropinsiBersama,
        "kdDati2Bersama": kdDati2Bersama,
        "kdKecamatanBersama": kdKecamatanBersama,
        "kdKelurahanBersama": kdKelurahanBersama,
        "kdBlokBersama": kdBlokBersama,
        "noUrutBersama": noUrutBersama,
        "kdJnsOpBersama": kdJnsOpBersama,
        "kdPropinsiAsal": kdPropinsiAsal,
        "kdDati2Asal": kdDati2Asal,
        "kdKecamatanAsal": kdKecamatanAsal,
        "kdKelurahanAsal": kdKelurahanAsal,
        "kdBlokAsal": kdBlokAsal,
        "noUrutAsal": noUrutAsal,
        "kdJnsOpAsal": kdJnsOpAsal,
        "noSpptLama": noSpptLama,
        "jalanOp": jalanOp,
        "blokKavNoOp": blokKavNoOp,
        "kelurahanOp": kelurahanOp,
        "rwOp": rwOp,
        "rtOp": rtOp,
        "kdStatusWp": kdStatusWp,
        "luasBumi": luasBumi,
        "kdZnt": kdZnt,
        "jnsBumi": jnsBumi,
        "nilaiSistemBumi": nilaiSistemBumi,
        "tglPendataanOp":
            tglPendataanOp?.toIso8601String(),
        "nmPendataanOp": nmPendataanOp,
        "nipPendata": nipPendata,
        "tglPemeriksaanOp":
            tglPemeriksaanOp?.toIso8601String(),
        "nmPemeriksaanOp": nmPemeriksaanOp,
        "nipPemeriksaOp": nipPemeriksaOp,
        "noPersil": noPersil,
        "subjekPajak": subjekPajak.toJson(),
        "anggota": anggota,
        "induk": induk,
      };
}

class GetByNopSubjekPajak {
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

  GetByNopSubjekPajak({
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

  factory GetByNopSubjekPajak.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetByNopSubjekPajak(
        subjekPajakId:
            json["subjekPajakId"]?.toString() ?? "",

        nmWp:
            json["nmWp"]?.toString() ?? "",

        jalanWp:
            json["jalanWp"]?.toString() ?? "",

        blokKavNoWp:
            json["blokKavNoWp"]?.toString() ?? "",

        rwWp:
            json["rwWp"]?.toString() ?? "",

        rtWp:
            json["rtWp"]?.toString() ?? "",

        kelurahanWp:
            json["kelurahanWp"]?.toString() ?? "",

        kotaWp:
            json["kotaWp"]?.toString() ?? "",

        kdPosWp:
            json["kdPosWp"]?.toString() ?? "",

        telpWp:
            json["telpWp"]?.toString() ?? "",

        npwp:
            json["npwp"]?.toString() ?? "",

        statusPekerjaanWp:
            json["statusPekerjaanWp"]?.toString() ?? "",

        emailWp:
            json["emailWp"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "subjekPajakId": subjekPajakId,
        "nmWp": nmWp,
        "jalanWp": jalanWp,
        "blokKavNoWp": blokKavNoWp,
        "rwWp": rwWp,
        "rtWp": rtWp,
        "kelurahanWp": kelurahanWp,
        "kotaWp": kotaWp,
        "kdPosWp": kdPosWp,
        "telpWp": telpWp,
        "npwp": npwp,
        "statusPekerjaanWp": statusPekerjaanWp,
        "emailWp": emailWp,
      };
}