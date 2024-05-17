// Import necessary packages and files
// ignore_for_file: avoid_print

import 'package:flutter_application_1/env/constants/open_ai.dart';
import 'package:flutter_application_1/models/cost_model.dart';
import 'package:flutter_application_1/screens/main_screens/invoice.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_application_1/models/kota_model.dart';
import 'package:flutter_application_1/models/provinsi_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/services/api_raja_ongkir.dart';
import 'package:google_fonts/google_fonts.dart';

class Pembelian extends StatefulWidget {
  final Map<String, dynamic> item;

  const Pembelian({Key? key, required this.item}) : super(key: key);

  @override
  State<Pembelian> createState() => _PembelianState();
}

class _PembelianState extends State<Pembelian> {
  final TextEditingController beratController = TextEditingController();
  final TextEditingController kuantitasController = TextEditingController();
  final TextEditingController hargaFinalController = TextEditingController();
  final TextEditingController ongkirController = TextEditingController();
  final TextEditingController layananController = TextEditingController();
  final TextEditingController totalBayarController = TextEditingController();
  final TextEditingController estimasiController = TextEditingController();

  String selectedCourier = 'Pilih Kurir';
  int beratInt = 0;
  int provId = 1;

  String alamatAsal = '0';
  String alamatTujuan = '0';
  String namaProvinsiAsal = '0';
  String namaKotaAsal = '0';
  String namaProvinsiTujuan = '0';
  String namaKotaTujuan = '0';
  double notaBerat = 0;
  double notaDiskon = 0;
  int notaBarangKuantitas = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Pembelian',
          style: GoogleFonts.poppins(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.item['gambar'] ?? 'https://via.placeholder.com/150',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                widget.item['nama'],
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Harga: ${widget.item['harga']}',
                  style: GoogleFonts.poppins()),
              Text('Berat: ${widget.item['berat']} gram',
                  style: GoogleFonts.poppins()),
              Text(
                  widget.item['promo'] == '0'
                      ? ''
                      : 'Diskon(${widget.item['promo']}%)',
                  style: GoogleFonts.poppins()),
              const SizedBox(height: 50),
              TextFormField(
                onChanged: (value) {
                  String beratString = widget.item['berat'];
                  String hargaString = widget.item['harga'];
                  String diskonString = widget.item['promo'];
                  int beratInt = int.parse(beratString);
                  int hargaInt = int.parse(hargaString);
                  int diskonInt = int.parse(diskonString);

                  String kuantitasString = kuantitasController.text;
                  int kuantitasInt = int.parse(kuantitasString);

                  double gramtoKg = ((beratInt * kuantitasInt) / 1000);

                  setState(() {
                    notaBerat = gramtoKg;
                  });

                  setState(() {
                    notaBarangKuantitas = hargaInt * kuantitasInt;
                  });

                  double hargakalkulasi = ((hargaInt * kuantitasInt) -
                      (hargaInt * kuantitasInt * (diskonInt / 100)));
                  String hargafinal = hargakalkulasi.toString();
                  hargaFinalController.text = hargafinal;

                  setState(() {
                    notaDiskon = hargaInt * kuantitasInt * (diskonInt / 100);
                  });

                  String kg = gramtoKg.toString();

                  beratController.text = kg;

                  try {
                    double beratInt = double.parse(beratController.text);

                    double berat = (beratInt * 1000);
                    Map<String, String> data = {
                      'origin': alamatAsal,
                      'destination': alamatTujuan,
                      'weight': berat.toString(),
                      'courier': selectedCourier,
                    };
                    callRajaOngkirAPI(data);
                  } catch (e) {
                    print('err: $e');
                  }
                },
                controller: kuantitasController,
                decoration: InputDecoration(
                  labelText: 'Kuantitas',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Alamat Asal",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownSearch<Province>(
                popupProps: const PopupProps.menu(showSearchBox: true),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Provinsi",
                    labelStyle: GoogleFonts.poppins(),
                    hintText: "isikan provinsi",
                  ),
                ),
                asyncItems: (String filter) async {
                  Uri url =
                      Uri.parse("https://api.rajaongkir.com/starter/province");
                  try {
                    final response = await http.get(
                      url,
                      headers: {
                        "key": rajaOngkirApiKey,
                        "content-type": "application/x-www-form-urlencoded",
                      },
                    );
                    var data =
                        jsonDecode(response.body) as Map<String, dynamic>;

                    var statusCode = data["rajaongkir"]["status"]["code"];
                    if (statusCode != 200) {
                      throw data["rajaongkir"]["status"]["description"];
                    }

                    var listAllProvince =
                        data["rajaongkir"]["results"] as List<dynamic>;
                    var models = Province.fromJsonList(listAllProvince);
                    return models;
                  } catch (err) {
                    print(err);
                    return List<Province>.empty();
                  }
                },
                // onChanged: (value) => print(value!.province),
                onChanged: (prov) {
                  if (prov != null) {
                    provId = int.parse(prov.provinceid!);
                  } else {
                    print("provinsi null");
                  }
                },
                itemAsString: (item) => item.province!,
              ),
              const SizedBox(height: 20),
              DropdownSearch<Kota>(
                popupProps: const PopupProps.menu(showSearchBox: true),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Kota",
                    labelStyle: GoogleFonts.poppins(),
                    hintText: "isikan kota",
                  ),
                ),
                asyncItems: (String filter) async {
                  Uri url = Uri.parse(
                      "https://api.rajaongkir.com/starter/city?province=$provId");
                  try {
                    final response = await http.get(
                      url,
                      headers: {
                        "key": rajaOngkirApiKey,
                        "content-type": "application/x-www-form-urlencoded",
                      },
                    );
                    var data =
                        jsonDecode(response.body) as Map<String, dynamic>;

                    var statusCode = data["rajaongkir"]["status"]["code"];
                    if (statusCode != 200) {
                      throw data["rajaongkir"]["status"]["description"];
                    }

                    var listAllKota =
                        data["rajaongkir"]["results"] as List<dynamic>;
                    var models = Kota.fromJsonList(listAllKota);
                    return models;
                  } catch (err) {
                    print(err);
                    return List<Kota>.empty();
                  }
                },
                onChanged: (value) => setState(() {
                  alamatAsal = value!.cityId.toString();
                }),
                itemAsString: (item) => item.cityName!,
              ),
              const SizedBox(height: 20),
              const Text(
                "Alamat Tujuan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownSearch<Province>(
                popupProps: const PopupProps.menu(showSearchBox: true),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Provinsi",
                    labelStyle: GoogleFonts.poppins(),
                    hintText: "isikan provinsi",
                  ),
                ),
                asyncItems: (String filter) async {
                  Uri url =
                      Uri.parse("https://api.rajaongkir.com/starter/province");
                  try {
                    final response = await http.get(
                      url,
                      headers: {
                        "key": rajaOngkirApiKey,
                        "content-type": "application/x-www-form-urlencoded",
                      },
                    );
                    var data =
                        jsonDecode(response.body) as Map<String, dynamic>;

                    var statusCode = data["rajaongkir"]["status"]["code"];
                    if (statusCode != 200) {
                      throw data["rajaongkir"]["status"]["description"];
                    }

                    var listAllProvince =
                        data["rajaongkir"]["results"] as List<dynamic>;
                    var models = Province.fromJsonList(listAllProvince);
                    return models;
                  } catch (err) {
                    print(err);
                    return List<Province>.empty();
                  }
                },
                // onChanged: (value) => print(value!.province),
                onChanged: (prov) {
                  if (prov != null) {
                    provId = int.parse(prov.provinceid!);
                  } else {
                    print("provinsi null");
                  }
                },
                itemAsString: (item) => item.province!,
              ),
              const SizedBox(height: 20),
              DropdownSearch<Kota>(
                popupProps: const PopupProps.menu(showSearchBox: true),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Kota",
                    labelStyle: GoogleFonts.poppins(),
                    hintText: "isikan kota",
                  ),
                ),
                asyncItems: (String filter) async {
                  Uri url = Uri.parse(
                      "https://api.rajaongkir.com/starter/city?province=$provId");
                  try {
                    final response = await http.get(
                      url,
                      headers: {
                        "key": rajaOngkirApiKey,
                        "content-type": "application/x-www-form-urlencoded",
                      },
                    );
                    var data =
                        jsonDecode(response.body) as Map<String, dynamic>;

                    var statusCode = data["rajaongkir"]["status"]["code"];
                    if (statusCode != 200) {
                      throw data["rajaongkir"]["status"]["description"];
                    }

                    var listAllKota =
                        data["rajaongkir"]["results"] as List<dynamic>;
                    var models = Kota.fromJsonList(listAllKota);
                    return models;
                  } catch (err) {
                    print(err);
                    return List<Kota>.empty();
                  }
                },
                onChanged: (value) => setState(() {
                  alamatTujuan = value!.cityId.toString();
                }),
                itemAsString: (item) => item.cityName!,
              ),
              const SizedBox(height: 20),
              const Text(
                "Pilih Kurir",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                children: <Widget>[
                  RadioListTile<String>(
                    title: Text(
                      'JNE (Jalur Nugraha Ekakurir)',
                      style: GoogleFonts.poppins(),
                    ),
                    value: 'jne',
                    groupValue: selectedCourier,
                    onChanged: (String? value) async {
                      setState(() {
                        selectedCourier = value!;
                      });
                      _calculateShippingCost();
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('POS (Pos Indonesia)',
                        style: GoogleFonts.poppins()),
                    value: 'pos',
                    groupValue: selectedCourier,
                    onChanged: (String? value) async {
                      setState(() {
                        selectedCourier = value!;
                      });
                      _calculateShippingCost();
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('TIKI (Titipan Kilat)',
                        style: GoogleFonts.poppins()),
                    value: 'tiki',
                    groupValue: selectedCourier,
                    onChanged: (String? value) async {
                      setState(() {
                        selectedCourier = value!;
                      });
                      _calculateShippingCost();
                    },
                  ),
                ],
              ),
              TextFormField(
                readOnly: true,
                controller: layananController,
                decoration: InputDecoration(
                  labelText: 'Layanan',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: estimasiController,
                decoration: InputDecoration(
                  labelText: 'Estimasi Kedatangan (Hari)',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Kalkulasi Harga",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                controller: beratController,
                decoration: InputDecoration(
                  labelText: 'Berat (KG)',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: hargaFinalController,
                decoration: InputDecoration(
                  labelText: 'Harga Produk Setelah Diskon (IDR)',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: ongkirController,
                decoration: InputDecoration(
                  labelText: 'Ongkos Kirim (IDR)',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: totalBayarController,
                decoration: InputDecoration(
                  labelText: 'Total Pembayaran (IDR)',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  try {
                    if (totalBayarController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Invoice(
                            namaBarang: widget.item['nama'],
                            hargaBarang: widget.item['harga'],
                            hargaBarangKuantitas:
                                notaBarangKuantitas.toString(),
                            beratBarang: notaBerat.toString(),
                            promoBarang: widget.item['promo'],
                            kuantitas: kuantitasController.text,
                            provinsiAsal: namaProvinsiAsal,
                            alamatAsal: namaKotaAsal,
                            provinsiTujuan: namaProvinsiTujuan,
                            alamatTujuan: namaKotaTujuan,
                            selectedCourier: selectedCourier,
                            layanan: layananController.text,
                            ongkir: ongkirController.text,
                            diskon: notaDiskon.toString(),
                            totalBayar: totalBayarController.text,
                            etd: estimasiController.text,
                          ),
                        ),
                      );
                    } else {
                      print("Total bayar harus ada value masszeh");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form masih belum terisi'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.blueAccent,
                        ),
                      );
                    }
                  } catch (e) {
                    print('err: $e');
                  }
                },
                child: Text(
                  'Bayar',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void callRajaOngkirAPI(Map<String, String> data) async {
    try {
      String result = await RajaOngkirApi.getShippingCost(data);

      Map<String, dynamic> jsonResponse = json.decode(result);
      RajaOngkirResponse response = RajaOngkirResponse.fromJson(jsonResponse);
      ongkirController.text =
          response.rajaongkir.results[0].costs[0].cost[0].value.toString();
      layananController.text =
          response.rajaongkir.results[0].costs[0].service.toString();
      estimasiController.text =
          response.rajaongkir.results[0].costs[0].cost[0].etd;

      double hargaBarang = double.parse(hargaFinalController.text);
      int hargaOngkir = int.parse(ongkirController.text);

      totalBayarController.text = (hargaBarang + hargaOngkir).toString();

      setState(() {
        namaProvinsiAsal = response.rajaongkir.originDetails.province;
        namaKotaAsal = response.rajaongkir.originDetails.cityName;

        namaProvinsiTujuan = response.rajaongkir.destinationDetails.province;
        namaKotaTujuan = response.rajaongkir.destinationDetails.cityName;
      });

      print(response.rajaongkir.originDetails.cityName);
      print(response.rajaongkir.destinationDetails.cityName);
      print(response.rajaongkir.results[0].name);
      print(response.rajaongkir.results[0].costs[0].service);
      print(response.rajaongkir.results[0].costs[0].cost[0].value);
    } catch (error) {
      print(error);
    }
  }

  void _calculateShippingCost() async {
    try {
      double beratInt = double.parse(beratController.text);
      double berat = (beratInt * 1000);
      Map<String, String> data = {
        'origin': alamatAsal,
        'destination': alamatTujuan,
        'weight': berat.toString(),
        'courier': selectedCourier,
      };
      callRajaOngkirAPI(data);
    } catch (e) {
      print('err: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Kurir yang Anda pilih tidak tersedia.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
