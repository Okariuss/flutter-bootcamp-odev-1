// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_music/model/music.dart';

class RecommendedMusicVideosWidget extends StatelessWidget {
  final AppLocalizations d;
  final Music music;
  const RecommendedMusicVideosWidget({
    required this.d,
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
                height: 200,
                width: 400,
                child: Image.network(
                  music.musicImageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(music.musicName),
                Row(
                  children: [
                    Text(
                      "${music.musicInstructor} * ",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                    Text(
                      "${music.totalViews} ${d.views}",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                  ],
                )
              ],
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
