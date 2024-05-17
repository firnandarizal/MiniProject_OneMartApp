import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/screens/main_screens/dashboard_screen.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const EditPage({Key? key, required this.item}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController namaController;
  late TextEditingController hargaController;
  late TextEditingController promoController;
  late TextEditingController beratController;
  late TextEditingController deskripsiController;
  late TextEditingController gambarController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.item['nama']);
    hargaController =
        TextEditingController(text: widget.item['harga'].toString());
    promoController =
        TextEditingController(text: widget.item['promo'].toString());
    beratController =
        TextEditingController(text: widget.item['berat'].toString());
    deskripsiController = TextEditingController(text: widget.item['deskripsi']);
    gambarController = TextEditingController(text: widget.item['gambar']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit ${widget.item['nama']}"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: namaController,
                      decoration: const InputDecoration(
                          labelText: 'Nama', border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: hargaController,
                      decoration: const InputDecoration(
                          labelText: 'Harga', border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: promoController,
                      decoration: const InputDecoration(
                          labelText: 'Promo', border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: beratController,
                      decoration: const InputDecoration(
                          labelText: 'Berat (gram)',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: deskripsiController,
                      decoration: const InputDecoration(
                          labelText: 'Deskripsi', border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: gambarController,
                      decoration: const InputDecoration(
                          labelText: 'Gambar (Link)',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          widget.item['nama'] = namaController.text;
                          widget.item['harga'] = hargaController.text;
                          widget.item['promo'] = promoController.text;
                          widget.item['berat'] = beratController.text;
                          widget.item['deskripsi'] = deskripsiController.text;
                          widget.item['gambar'] = gambarController.text;

                          Map<String, dynamic> updatedItem = {
                            'nama': widget.item['nama'],
                            'harga': widget.item['harga'],
                            'promo': widget.item['promo'],
                            'berat': widget.item['berat'],
                            'deskripsi': widget.item['deskripsi'],
                            'gambar': widget.item['gambar'],
                          };
                          try {
                            await ApiService.updateItem(
                                widget.item['id'], updatedItem);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Produk berhasil diubah!'),
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
                        child: const Text('Ubah',
                            style: TextStyle(color: Colors.orange)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
