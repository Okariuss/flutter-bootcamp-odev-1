import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final Color color;
  final String name;
  final void Function()? onPressed;

  const DefaultButton(
      {super.key, required this.color, required this.name, this.onPressed});
  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const LinearBorder(),
          backgroundColor: widget.color,
          foregroundColor: Colors.grey,
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
