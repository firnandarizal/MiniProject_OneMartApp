class ProductModel {
  final int id;
  final String nama;
  final String harga;
  final String promo;
  final String deskripsi;
  final String berat;
  final String gambar;

  ProductModel(
      {required this.id,
      required this.nama,
      required this.harga,
      required this.promo,
      required this.deskripsi,
      required this.berat,
      required this.gambar});

  // function fromJson
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        promo: json['promo'],
        deskripsi: json['deskripsi'],
        berat: json['berat'],
        gambar: json['gambar']);
  }

  // function to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'promo': promo,
      'deskripsi': deskripsi,
      'berat': berat,
      'gambar': gambar
    };
  }
}
