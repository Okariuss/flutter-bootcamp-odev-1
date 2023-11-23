// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:youtube_music/model/music.dart';

class ListenAgainWidget extends StatelessWidget {
  final Music music;
  const ListenAgainWidget({
    required this.music,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: SizedBox(
                height: 125,
                child: Image.network(music.musicImageUrl),
              ),
            ),
            Text(
              music.musicName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const Center(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 50,
          ),
        ),
      ],
    );
  }
}
