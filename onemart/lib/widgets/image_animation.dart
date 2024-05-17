import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/text_color.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kDefaultPadding),
          Row(
            children: [
              const SizedBox(width: kDefaultPadding),
              Expanded(
                child: Hero(
                  tag: '${item['id']}',
                  child: Image.network(
                    item['gambar'],
                    height: 350,
                    width: 100,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
