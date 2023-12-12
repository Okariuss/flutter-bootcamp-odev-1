import 'package:flutter/material.dart';

class EmptyFavorite extends StatelessWidget {
  const EmptyFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No favorites yet.'),
    );
  }
}
