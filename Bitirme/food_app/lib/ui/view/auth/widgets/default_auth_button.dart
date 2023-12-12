import 'package:flutter/material.dart';

class DefaultAuthButton extends StatelessWidget {
  const DefaultAuthButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
