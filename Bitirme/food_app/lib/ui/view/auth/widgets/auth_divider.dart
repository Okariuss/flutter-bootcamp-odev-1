import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.primaryColor,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      height: 16,
    );
  }
}
