// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class DefaultAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAuthAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
