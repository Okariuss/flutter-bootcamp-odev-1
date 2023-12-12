import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/core/constants/app_lotties.dart';
import 'package:food_app/data/entity/onboard/slider_page_variables.dart';

class AppSliders {
  static SliderPageVariables? getSlider(int index, AppLocalizations d) {
    switch (index) {
      case 0:
        return SliderPageVariables(
            imageName: AppLotties.welcomeLottie,
            header: d.welcome,
            subtitle: d.welcome_text);

      case 1:
        return SliderPageVariables(
            imageName: AppLotties.favoriteLottie,
            header: d.all_favorites,
            subtitle: d.all_favorites_text);
      case 2:
        return SliderPageVariables(
            imageName: AppLotties.deliciousLottie,
            header: d.delicious_food,
            subtitle: d.delicious_food_text);
      case 3:
        return SliderPageVariables(
            imageName: AppLotties.chooseLottie,
            header: d.choose_food,
            subtitle: d.choose_food_text);

      default:
        return null;
    }
  }
}
