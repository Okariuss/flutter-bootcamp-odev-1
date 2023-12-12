// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';

class DefaultCartProductTitle extends StatelessWidget {
  const DefaultCartProductTitle({
    super.key,
    required this.product,
  });

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    return Text(
      product.productName!,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
