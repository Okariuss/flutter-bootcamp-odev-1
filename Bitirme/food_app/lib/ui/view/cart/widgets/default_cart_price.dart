import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/data/entity/cart/cart_product.dart';

class DefaultCartPrice extends StatelessWidget {
  const DefaultCartPrice({
    super.key,
    required this.product,
  });

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    return Text(
      d.price == "₺"
          ? "${product.productPrice! * product.quantity} ${d.price}"
          : "${(product.productPrice! * product.quantity / 30).toStringAsFixed(2)} ${d.price}",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
