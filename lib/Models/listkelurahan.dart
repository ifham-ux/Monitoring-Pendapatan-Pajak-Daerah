class listkelurahan {
  String kdKelurahan;
  String nmKelurahan;

  listkelurahan({
    required this.kdKelurahan,
    required this.nmKelurahan
  });

  factory listkelurahan.fromJson(Map<String, dynamic> json) {
    return listkelurahan(
      kdKelurahan: json['kdKelurahan']?.toString() ?? '',
      nmKelurahan: json['nmKelurahan']?.toString() ?? '',
    );
  }
}