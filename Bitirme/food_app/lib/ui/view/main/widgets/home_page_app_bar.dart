import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/data/utils/preference_service.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
    required this.prefs,
    required this.d,
  });

  final PreferencesService prefs;

  final AppLocalizations d;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${d.hello}, ${prefs.username}",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Text(
              d.what_would_eat,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
