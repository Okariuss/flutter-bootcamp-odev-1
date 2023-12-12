import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({
    super.key,
    required this.d,
  });

  final AppLocalizations d;

  @override
  Widget build(BuildContext context) {
    return Text(d.cart);
  }
}
