import 'package:flutter/material.dart';

class ResultText extends StatefulWidget {
  const ResultText({
    super.key,
    required this.result,
    required this.fontSize,
  });

  final String result;
  final double fontSize;

  @override
  State<ResultText> createState() => _ResultTextState();
}

class _ResultTextState extends State<ResultText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.result,
      style: TextStyle(
        fontSize: widget.fontSize,
        color: Colors.white,
      ),
    );
  }
}
