import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/data/entity/product/product.dart';

class DefaultFavoriteCardProductPrice extends StatelessWidget {
  const DefaultFavoriteCardProductPrice({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    return Text(
      d.price == "₺"
          ? "${product.price} ${d.price}"
          : "${(product.price / 30).toStringAsFixed(2)} ${d.price}",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
