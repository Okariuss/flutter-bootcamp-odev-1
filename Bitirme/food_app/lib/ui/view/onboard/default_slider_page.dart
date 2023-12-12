// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_app/core/constants/app_images.dart';
import 'package:food_app/core/constants/app_sliders.dart';
import 'package:lottie/lottie.dart';

class DefaultSliderPage extends StatefulWidget {
  final int index;
  const DefaultSliderPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<DefaultSliderPage> createState() => _DefaultSliderPageState();
}

class _DefaultSliderPageState extends State<DefaultSliderPage> {
  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var sliderPage = AppSliders.getSlider(widget.index, d);

    var width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width / 5,
                child: Image.asset(AppImages.appIcon),
              ),
              Text(
                d.food_service,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
              width: width / 1.75,
              child: Lottie.asset(sliderPage?.imageName ?? "")),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                sliderPage?.header ?? "",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                sliderPage?.subtitle ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
