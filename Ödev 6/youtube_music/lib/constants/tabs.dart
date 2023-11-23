import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabsConstants {
  static String getTabTitle(int index, AppLocalizations d) {
    switch (index) {
      case 0:
        return d.energize;
      case 1:
        return d.workout;
      case 2:
        return d.relax;
      case 3:
        return d.feelGood;
      case 4:
        return d.party;
      case 5:
        return d.romance;
      case 6:
        return d.focus;
      case 7:
        return d.sad;
      case 8:
        return d.sleep;
      case 9:
        return d.commute;
      default:
        return "Tab $index";
    }
  }
}
