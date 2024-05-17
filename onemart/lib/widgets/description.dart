import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/text_color.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.item,
  });

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Text(item['deskripsi'], style: GoogleFonts.poppins()),
    );
  }
}
