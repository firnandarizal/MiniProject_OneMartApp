import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DateTimeProvider with ChangeNotifier {
  String getCurrentDateTime() {
    return DateFormat('dd MMMM yyyy - HH:mm:ss').format(DateTime.now());
  }
}

class Invoice extends StatefulWidget {
  final String namaBarang;
  final String hargaBarang;
  final String hargaBarangKuantitas;
  final String beratBarang;
  final String promoBarang;
  final String kuantitas;
  final String provinsiAsal;
  final String alamatAsal;
  final String provinsiTujuan;
  final String alamatTujuan;
  final String selectedCourier;
  final String layanan;
  final String ongkir;
  final String diskon;
  final String totalBayar;
  final String etd;

  const Invoice({super.key, 
    required this.namaBarang,
    required this.hargaBarang,
    required this.hargaBarangKuantitas,
    required this.beratBarang,
    required this.promoBarang,
    required this.kuantitas,
    required this.provinsiAsal,
    required this.alamatAsal,
    required this.provinsiTujuan,
    required this.alamatTujuan,
    required this.selectedCourier,
    required this.layanan,
    required this.ongkir,
    required this.diskon,
    required this.totalBayar,
    required this.etd,
  });

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  late SharedPreferences _prefs;
  late String? userName = '';
  late String? userTelp = '';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    userName = _prefs.getString('user_nama');
    userTelp = _prefs.getString('user_telp');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text(
          'Invoice',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _prefs.clear();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Dashboard();
              }));
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<DateTimeProvider>(
                builder: (context, dateTimeProvider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Invoice',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            dateTimeProvider.getCurrentDateTime(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(color: Colors.black),
                      Text(
                        'Produk',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Nama Produk',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.namaBarang,
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Harga',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Rp. ${widget.hargaBarang} x ${widget.kuantitas}",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Berat Total',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${widget.beratBarang} KG",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Promo',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${widget.promoBarang}%",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Divider(color: Colors.black),
                      const SizedBox(height: 9),
                      Text(
                        'Alamat Pengiriman',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Alamat Awal',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${widget.alamatAsal}, ${widget.provinsiAsal}",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Alamat Tujuan',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${widget.alamatTujuan}, ${widget.provinsiTujuan}",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Kurir',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.selectedCourier.toUpperCase(),
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Layanan',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.layanan,
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Estimasi Kedatangan',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${widget.etd} Hari",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Divider(color: Colors.black),
                      const SizedBox(height: 9),
                      Text(
                        'Pembayaran',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Total Harga Barang',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Rp. ${widget.hargaBarangKuantitas}",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Harga Ongkir',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Rp. ${widget.ongkir}",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Diskon',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "-Rp. ${widget.diskon}",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      const SizedBox(height: 2),
                      ListTile(
                        title: Text(
                          'Total Pembayaran',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Rp. ${widget.totalBayar}",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.black),
                      const SizedBox(height: 9),
                      Text(
                        'Info Pemesan',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Nama Pemesan',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          userName.toString(),
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'No Telepon Pemesan',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          userTelp.toString(),
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Real-time date and time
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
