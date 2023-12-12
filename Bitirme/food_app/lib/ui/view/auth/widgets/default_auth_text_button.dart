import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';

class DefaultAuthTextButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  const DefaultAuthTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.primaryTextButtonColor),
      ),
    );
  }
}
