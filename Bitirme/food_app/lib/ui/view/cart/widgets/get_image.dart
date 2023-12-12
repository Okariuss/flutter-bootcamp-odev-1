import 'package:flutter/material.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';

class GetImage extends StatelessWidget {
  const GetImage({
    super.key,
    required this.product,
  });

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.network(
        product.productImageUrl!,
      ),
    );
  }
}
