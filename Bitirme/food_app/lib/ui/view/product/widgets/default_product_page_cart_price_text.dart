import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/ui/view/product/product_page.dart';

class DefaultProductPageCartPriceText extends StatelessWidget {
  const DefaultProductPageCartPriceText({
    super.key,
    required this.widget,
    required this.d,
  });

  final ProductPage widget;

  final AppLocalizations d;

  @override
  Widget build(BuildContext context) {
    return Text(
      d.price == "₺"
          ? "${widget.product.price} ${d.price}"
          : "${(widget.product.price / 30).toStringAsFixed(2)} ${d.price}",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
