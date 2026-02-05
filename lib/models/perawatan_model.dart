class PerawatanModel {
  final String id;
  final String namaBarang;
  final String jenisBarang;
  final String jenisPerawatan;
  final String tanggalPerawatan;
  final String biayaPerawatan;
  final String hasilPerawatan;
  final String statusBarang;

  PerawatanModel({
    required this.id,
    required this.namaBarang,
    required this.jenisBarang,
    required this.jenisPerawatan,
    required this.tanggalPerawatan,
    required this.biayaPerawatan,
    required this.hasilPerawatan,
    required this.statusBarang,
  });

  factory PerawatanModel.fromJson(Map<String, dynamic> json) {
    return PerawatanModel(
      id: json['id'].toString(),
      namaBarang: json['nama_barang'] ?? '',
      jenisBarang: json['jenis_barang'] ?? '',
      jenisPerawatan: json['jenis_perawatan'] ?? '',
      tanggalPerawatan: json['tanggal_perawatan'] ?? '',
      biayaPerawatan: json['biaya_perawatan'].toString(),
      hasilPerawatan: json['hasil_perawatan'] ?? '',
      statusBarang: json['status_barang'] ?? '',
    );
  }
}