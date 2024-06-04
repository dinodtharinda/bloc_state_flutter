import 'package:bloc_state_flutter/features/home/models/home_product_data.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel product;
  const ProductTileWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text(product.description),
    );
  }
}
