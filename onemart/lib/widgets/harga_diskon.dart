import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/text_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    super.key,
    required this.item,
  });

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Harga',
                  style: GoogleFonts.poppins(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                children: [
                  Text('Rp.${item['harga']}',
                      style: GoogleFonts.poppins(
                        color: kTextColor,
                      ))
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: kTextColor),
              children: [
                TextSpan(
                    text: 'Diskon\n',
                    style: GoogleFonts.poppins(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(
                  text: item['promo'] == '0' ? '' : '${item['promo']}%',
                  style: GoogleFonts.poppins(
                    color: kTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
