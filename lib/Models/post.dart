class Post {
  final String nmWpSppt;
  final String kdKecamatan;
  final String jalanOp;

  Post({
    required this.nmWpSppt,
    required this.kdKecamatan,
    required this.jalanOp,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      nmWpSppt: json['nmWpSppt']?.toString() ?? 'N/A',
      kdKecamatan: json['kdKecamatan']?.toString() ?? 'N/A',
      jalanOp: json['jalanOp']?.toString() ?? 'N/A',
    );
  }
}