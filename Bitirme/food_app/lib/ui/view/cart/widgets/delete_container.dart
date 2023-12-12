import 'package:flutter/material.dart';

class DeleteContainer extends StatelessWidget {
  const DeleteContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
