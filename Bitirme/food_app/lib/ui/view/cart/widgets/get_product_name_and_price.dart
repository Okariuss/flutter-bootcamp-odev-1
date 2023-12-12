import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';

class GetProductNameAndPrice extends StatelessWidget {
  const GetProductNameAndPrice({
    super.key,
    required this.product,
  });

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(product.productName!),
        const SizedBox(
          height: 10,
        ),
        Text(
          d.price == "₺"
              ? "${product.productPrice! * product.quantity} ${d.price}"
              : "${(product.productPrice! * product.quantity / 30).toStringAsFixed(2)} ${d.price}",
        ),
      ],
    );
  }
}
