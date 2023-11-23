// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_music/model/musician.dart';

class SimilarToWidget extends StatelessWidget {
  final AppLocalizations d;
  final Musician musician;

  const SimilarToWidget({
    required this.d,
    required this.musician,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: SizedBox(
            height: 200,
            width: 400,
            child: Image.network(
              musician.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(musician.name),
            Text(
              "${musician.followers} ${d.followers}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
