import 'package:flutter/material.dart';
import 'package:food_app/data/entity/product/product.dart';

class DefaultFavoriteCardProductName extends StatelessWidget {
  const DefaultFavoriteCardProductName({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Text(
      product.name,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
