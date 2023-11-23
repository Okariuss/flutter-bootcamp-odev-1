import 'dart:math';

import 'package:youtube_music/constants/musicians/image_constants.dart';
import 'package:youtube_music/constants/musicians/musician_constants.dart';
import 'package:youtube_music/constants/musicians/subscribers_constants.dart';

import '../constants/music/image_constants.dart';
import '../constants/music/instructor_constants.dart';
import '../constants/music/music_constants.dart';
import '../constants/music/total_views_constants.dart';
import '../model/music.dart';
import '../model/musician.dart';

class NetworkBrain {
  static Future<List<Music>> quickPicks() async {
    var musicList = <Music>[];
    var m1 = Music(
        musicImageUrl: MusicImageConstants.akliminIpleriniSaldim,
        musicName: MusicConstants.akliminIpleriniSaldim,
        musicInstructor: InstructorConstants.akliminIpleriniSaldim,
        totalViews: TotalViewsConstants.akliminIpleriniSaldim);
    var m2 = Music(
        musicImageUrl: MusicImageConstants.gelsinHayatBildigiGibi,
        musicName: MusicConstants.gelsinHayatBildigiGibi,
        musicInstructor: InstructorConstants.gelsinHayatBildigiGibi,
        totalViews: TotalViewsConstants.gelsinHayatBildigiGibi);
    var m3 = Music(
        musicImageUrl: MusicImageConstants.zor,
        musicName: MusicConstants.zor,
        musicInstructor: InstructorConstants.zor,
        totalViews: TotalViewsConstants.zor);
    var m4 = Music(
        musicImageUrl: MusicImageConstants.olsun,
        musicName: MusicConstants.olsun,
        musicInstructor: InstructorConstants.olsun,
        totalViews: TotalViewsConstants.olsun);
    var m5 = Music(
        musicImageUrl: MusicImageConstants.gecmisinYuku,
        musicName: MusicConstants.gecmisinYuku,
        musicInstructor: InstructorConstants.gecmisinYuku,
        totalViews: TotalViewsConstants.gecmisinYuku);
    var m6 = Music(
        musicImageUrl: MusicImageConstants.muhurluKaderim,
        musicName: MusicConstants.muhurluKaderim,
        musicInstructor: InstructorConstants.muhurluKaderim,
        totalViews: TotalViewsConstants.muhurluKaderim);
    var m7 = Music(
        musicImageUrl: MusicImageConstants.forsa,
        musicName: MusicConstants.forsa,
        musicInstructor: InstructorConstants.forsa,
        totalViews: TotalViewsConstants.forsa);
    var m8 = Music(
        musicImageUrl: MusicImageConstants.issizliginOrtasinda,
        musicName: MusicConstants.issizliginOrtasinda,
        musicInstructor: InstructorConstants.issizliginOrtasinda,
        totalViews: TotalViewsConstants.issizliginOrtasinda);
    var m9 = Music(
        musicImageUrl: MusicImageConstants.kirmisKalbini,
        musicName: MusicConstants.kirmisKalbini,
        musicInstructor: InstructorConstants.kirmisKalbini,
        totalViews: TotalViewsConstants.kirmisKalbini);
    var m10 = Music(
        musicImageUrl: MusicImageConstants.birthOfCreation,
        musicName: MusicConstants.birthOfCreation,
        musicInstructor: InstructorConstants.birthOfCreation,
        totalViews: TotalViewsConstants.birthOfCreation);
    var m11 = Music(
        musicImageUrl: MusicImageConstants.birseyYapmali,
        musicName: MusicConstants.birseyYapmali,
        musicInstructor: InstructorConstants.birseyYapmali,
        totalViews: TotalViewsConstants.birseyYapmali);
    var m12 = Music(
        musicImageUrl: MusicImageConstants.dursunZaman,
        musicName: MusicConstants.dursunZaman,
        musicInstructor: InstructorConstants.dursunZaman,
        totalViews: TotalViewsConstants.dursunZaman);
    var m13 = Music(
        musicImageUrl: MusicImageConstants.meleklerOlmez,
        musicName: MusicConstants.meleklerOlmez,
        musicInstructor: InstructorConstants.meleklerOlmez,
        totalViews: TotalViewsConstants.meleklerOlmez);
    var m14 = Music(
        musicImageUrl: MusicImageConstants.sonSabah,
        musicName: MusicConstants.sonSabah,
        musicInstructor: InstructorConstants.sonSabah,
        totalViews: TotalViewsConstants.sonSabah);
    musicList.add(m1);
    musicList.add(m2);
    musicList.add(m3);
    musicList.add(m4);
    musicList.add(m5);
    musicList.add(m6);
    musicList.add(m7);
    musicList.add(m8);
    musicList.add(m9);
    musicList.add(m10);
    musicList.add(m11);
    musicList.add(m12);
    musicList.add(m13);
    musicList.add(m14);
    return musicList;
  }

  static Future<List<Musician>> similarToMusician() async {
    var musicianList = <Musician>[];
    var m1 = Musician(
        imageUrl: MusicianImageConstants.fd,
        name: MusiciansConstants.fd,
        followers: SubscribersConstants.fd);
    var m2 = Musician(
        imageUrl: MusicianImageConstants.mfo,
        name: MusiciansConstants.mfo,
        followers: SubscribersConstants.mfo);
    var m3 = Musician(
        imageUrl: MusicianImageConstants.teoman,
        name: MusiciansConstants.teoman,
        followers: SubscribersConstants.teoman);
    musicianList.add(m1);
    musicianList.add(m2);
    musicianList.add(m3);

    return musicianList;
  }

  static Future<Music> getRandomMusic() async {
    final List<Music> allMusic = await quickPicks();
    final Random random = Random();
    final int randomNumber = random.nextInt(allMusic.length);

    return allMusic[randomNumber];
  }
}
