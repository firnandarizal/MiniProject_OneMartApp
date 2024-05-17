// ignore_for_file: use_build_context_synchronously

import 'package:flutter_application_1/screens/main_screens/checkout_screen.dart';
import 'package:flutter_application_1/screens/main_screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/widgets/harga_diskon.dart';
import 'package:flutter_application_1/widgets/text_color.dart';
import 'package:flutter_application_1/widgets/description.dart';
import 'package:flutter_application_1/widgets/image_animation.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(item['nama'], style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditPage(item: item)));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: () async {
              await ApiService.deleteData(item['id']);
              ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Produk berhasil dihapus'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ),
                        );

                        await Future.delayed(const Duration(seconds: 2));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Pembelian(item: item)));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.32),
                  padding: EdgeInsets.only(
                      top: size.height * 0.15,
                      left: kDefaultPadding,
                      right: kDefaultPadding),
                  height: 550.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: kDefaultPadding / 2),
                      ColorAndSize(item: item),
                      const SizedBox(height: kDefaultPadding / 2),
                      Description(item: item),
                      const SizedBox(height: kDefaultPadding / 2),
                    ],
                  ),
                ),
                ProductTitleWithImage(item: item),
                // ProductTitleWithImage(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
