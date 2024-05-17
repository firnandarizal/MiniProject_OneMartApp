import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/screens/main_screens/dashboard_screen.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPage createState() => _AddPage();
}

class _AddPage extends State<AddPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController promoController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController beratController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: hargaController,
                    decoration: const InputDecoration(
                      labelText: 'Harga',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: promoController,
                    decoration: const InputDecoration(
                      labelText: 'Promo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: beratController,
                    decoration: const InputDecoration(
                      labelText: 'Berat (gram)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: deskripsiController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: gambarController,
                    decoration: const InputDecoration(
                      labelText: 'Gambar (Link)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> newItem = {
                      'nama': namaController.text,
                      'harga': hargaController.text,
                      'promo': promoController.text,
                      'berat': beratController.text,
                      'deskripsi': deskripsiController.text,
                      'gambar': gambarController.text
                    };

                    try {
                      await ApiService.addItem(newItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Produk Berhasil Ditambahkan!'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );

                        await Future.delayed(const Duration(seconds: 2));

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    } catch (error) {
                      print('err: $error');
                    }
                  },
                  child: const Text('Tambahkan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
