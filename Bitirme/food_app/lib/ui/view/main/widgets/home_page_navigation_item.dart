import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageNavigationItem extends StatelessWidget {
  const HomePageNavigationItem({
    super.key,
    required this.d,
  });

  final AppLocalizations d;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      selectedIcon: const Icon(Icons.home),
      icon: const Icon(Icons.home_outlined),
      label: d.home,
    );
  }
}
