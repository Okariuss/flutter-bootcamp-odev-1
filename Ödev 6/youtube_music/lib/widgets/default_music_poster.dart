import 'package:flutter/material.dart';
import 'package:youtube_music/model/music.dart';

class DefaultMusicPoster extends StatelessWidget {
  final Music music;
  const DefaultMusicPoster({
    required this.music,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: Image.network(music.musicImageUrl),
      title: Text(
        music.musicName,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        music.musicInstructor,
        style:
            Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_vert_sharp),
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Card(
    //       child: SizedBox(
    //         height: 45,
    //         width: 45,
    //         child: Image.network(
    //           "https://lh3.googleusercontent.com/Ub6NoE0u-_NfHW6mofrk_w6F-gyPd14X5v9RGH5YsHvQLBYroLOGn6UT7K-GxOMy1S0CnYWKsnMsbvw=w544-h544-l90-rj",
    //           fit: BoxFit.fill,
    //         ),
    //       ),
    //     ),
    //     Column(
    //       children: [
    //         Text("Aklımın İplerini Saldım"),
    //         Text("Yüksek Sadakat"),
    //       ],
    //     ),
    //   ],
    // );
  }
}
