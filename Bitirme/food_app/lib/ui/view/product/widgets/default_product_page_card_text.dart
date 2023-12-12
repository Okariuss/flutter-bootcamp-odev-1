import 'package:flutter/material.dart';
import 'package:food_app/ui/view/product/product_page.dart';

class DefaultProductPageCardText extends StatelessWidget {
  const DefaultProductPageCardText({
    super.key,
    required this.widget,
  });

  final ProductPage widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.product.name,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
