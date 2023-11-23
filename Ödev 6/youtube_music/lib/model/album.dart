// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'music.dart';

class Album {
  String name;
  String musicianName;
  List<Music> musics;
  Album({
    required this.name,
    required this.musicianName,
    required this.musics,
  });
}
