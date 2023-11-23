import 'package:flutter/material.dart';

class DefaultMusicListsTitle extends StatelessWidget {
  final String? title, trailingText;
  final String? imagePath, subtitle;
  const DefaultMusicListsTitle(
      {this.title, this.subtitle, this.trailingText, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        title: (title != null)
            ? Text(
                title!,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                ),
              )
            : null,
        subtitle: (subtitle != null)
            ? Text(
                subtitle!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )
            : null,
        leading: (imagePath != null)
            ? CircleAvatar(
                radius: 30,
                child: Image.network(imagePath ?? ""),
              )
            : null,
        trailing: (trailingText != null)
            ? TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {},
                child: Text(trailingText!),
              )
            : null,
      ),
    );
  }
}
