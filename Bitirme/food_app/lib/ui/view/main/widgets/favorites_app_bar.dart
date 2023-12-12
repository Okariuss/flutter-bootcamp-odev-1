import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesAppBar extends StatelessWidget {
  const FavoritesAppBar({
    super.key,
    required this.d,
  });

  final AppLocalizations d;

  @override
  Widget build(BuildContext context) {
    return Text(d.favorites);
  }
}
