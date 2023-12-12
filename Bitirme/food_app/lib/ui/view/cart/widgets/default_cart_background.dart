// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class DefaultCartBackground extends StatelessWidget {
  const DefaultCartBackground({
    super.key,
    required this.deviceWidth,
  });

  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceWidth * 0.3,
      width: deviceWidth,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x4C000000),
            blurRadius: 10,
            offset: Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }
}
