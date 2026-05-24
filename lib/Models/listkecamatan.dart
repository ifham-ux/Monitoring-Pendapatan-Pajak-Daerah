class listkecamatan {
  String kdKecamatan;
  String nmKecamatan;

  listkecamatan({
    required this.kdKecamatan,
    required this.nmKecamatan
  });

  factory listkecamatan.fromJson(Map<String, dynamic> json) {
    return listkecamatan(
      kdKecamatan: json['kdKecamatan']?.toString() ?? '',
      nmKecamatan: json['nmKecamatan']?.toString() ?? '',
      
    );
  }
}