import 'package:flutter/material.dart';

class DefaultAuthTextFormField extends StatefulWidget {
  const DefaultAuthTextFormField({
    super.key,
    required this.defaultTfController,
    required this.name,
    this.obscureText = false,
    required this.validator,
  });

  final TextEditingController defaultTfController;
  final String name;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  State<DefaultAuthTextFormField> createState() =>
      _DefaultAuthTextFormFieldState();
}

class _DefaultAuthTextFormFieldState extends State<DefaultAuthTextFormField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        controller: widget.defaultTfController,
        obscureText: widget.obscureText ? _isObscure : false,
        decoration: InputDecoration(
          labelText: widget.name,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
        ),
        validator: widget.validator,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
