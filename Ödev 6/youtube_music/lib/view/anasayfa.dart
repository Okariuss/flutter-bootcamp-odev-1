import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:youtube_music/constants/appbar.dart';
import 'package:youtube_music/constants/colors.dart';
import 'package:youtube_music/extension/color_extension.dart';
import 'package:youtube_music/model/music.dart';
import 'package:youtube_music/model/musician.dart';
import 'package:youtube_music/viewmodel/scroll_notifier.dart';
import 'package:youtube_music/widgets/base_snapshot_control.dart';
import 'package:youtube_music/widgets/default_appbar_tab_button.dart';
import 'package:youtube_music/widgets/default_music_lists_title.dart';
import 'package:youtube_music/widgets/default_music_poster.dart';
import 'package:youtube_music/widgets/listen_again_widget.dart';
import 'package:youtube_music/widgets/recommended_music_videos_widget.dart';
import 'package:youtube_music/widgets/similar_to_widget.dart';

import '../network/network_brain.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int? _selectedTabIndex;
  int _selectedNavIndex = 0;
  late ScrollNotifier scrollNotifier;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollNotifier = ScrollNotifier();
    _tabController = TabController(vsync: this, length: 10);
    _scrollController.addListener(() {
      if (_scrollController.offset > 40 && !scrollNotifier.isScrolled) {
        scrollNotifier.updateScroll(true);
      } else if (_scrollController.offset <= 40 && scrollNotifier.isScrolled) {
        scrollNotifier.updateScroll(false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    return ChangeNotifierProvider.value(
      value: scrollNotifier,
      child: Scaffold(
        body: Consumer<ScrollNotifier>(
          builder: (context, value, child) {
            return Stack(
              children: [
                backgroundColor(),
                CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    appBar(d),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20),
                      sliver: DefaultMusicListsTitle(
                        title: d.startRadio,
                        subtitle: d.quickPicks,
                        trailingText: d.playAll,
                      ),
                    ),
                    horizontalGridSectionQuickPicks(),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20),
                      sliver: DefaultMusicListsTitle(
                        subtitle: d.listenAgain,
                        trailingText: d.more,
                      ),
                    ),
                    horizontalGridSectionListenAgain(),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20),
                      sliver: DefaultMusicListsTitle(
                        subtitle: d.recommended,
                        trailingText: d.playAll,
                      ),
                    ),
                    horizontalGridSectionRecommendedMusicVideos(d),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20),
                      sliver: FutureBuilder<Music>(
                        future: NetworkBrain.getRandomMusic(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SliverToBoxAdapter(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return SliverToBoxAdapter(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                            return const SliverToBoxAdapter(
                                child: Text('No data available'));
                          } else {
                            return DefaultMusicListsTitle(
                              title: d.similarTo,
                              subtitle: snapshot.data!.musicInstructor,
                              imagePath: snapshot.data!.musicImageUrl,
                            );
                          }
                        },
                      ),
                    ),
                    horizontalGridSectionSimilarTo(d),
                  ],
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: bottomNavBar(d),
      ),
    );
  }

  Container backgroundColor() {
    return scrollNotifier.isScrolled
        ? Container(color: Colors.black)
        : Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  ColorConstants.topLeftBackgroundColor,
                  ColorConstants.topRightBackgroundColor,
                  ColorConstants.blackColor,
                  ColorConstants.blackColor,
                  ColorConstants.blackColor,
                ],
              ),
            ),
          );
  }

  SliverAppBar appBar(AppLocalizations d) {
    return SliverAppBar(
      backgroundColor: scrollNotifier.isScrolled
          ? ColorConstants.blackColor
          : ColorConstants.transparent,
      floating: true,
      snap: true,
      pinned: true,
      title: SizedBox(
        width: 96,
        child: Image.asset(AppBarConstants.logoPath),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.cast)),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey,
            child: Text(AppBarConstants.avatarName),
          ),
          onPressed: () {},
        ),
      ],
      bottom: bottomAppBar(d),
    );
  }

  PreferredSize bottomAppBar(AppLocalizations d) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: SizedBox(
        height: 40,
        child: TabBar(
          controller: _tabController,
          padding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
          indicatorColor: Colors.transparent.getLighterColor(),
          isScrollable: true,
          tabs: List.generate(10, (index) {
            return DefaultAppBarTabButton(
              d: d,
              index: index,
              onPressed: () {
                setState(() {
                  _selectedTabIndex = index;
                  _tabController.animateTo(index);
                });
              },
              isSelected: _selectedTabIndex == index,
            );
          }),
        ),
      ),
    );
  }

  Widget bottomNavBar(AppLocalizations d) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: d.home,
        ),
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.compass),
          label: d.explore,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.library_music),
          label: d.library,
        ),
      ],
      currentIndex: _selectedNavIndex,
      selectedItemColor: ColorConstants.white,
      unselectedItemColor: ColorConstants.grey,
      backgroundColor: ColorConstants.transparent.getLighterColor(),
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _selectedNavIndex = index;
          _selectedTabIndex = null;
        });
      },
    );
  }

  SliverToBoxAdapter horizontalGridSectionQuickPicks() {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<Music>>(
        future: NetworkBrain.quickPicks(),
        builder: (context, snapshot) {
          return BaseSnapshotControl(
            snapshot: snapshot,
            widget: SizedBox(
              height: 300,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.2,
                ),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return DefaultMusicPoster(
                    music: snapshot.data![index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter horizontalGridSectionListenAgain() {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<Music>>(
        future: NetworkBrain.quickPicks(),
        builder: (context, snapshot) {
          return BaseSnapshotControl(
            snapshot: snapshot,
            widget: SizedBox(
              height: 325,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListenAgainWidget(
                    music: snapshot.data![index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter horizontalGridSectionRecommendedMusicVideos(
      AppLocalizations d) {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<Music>>(
        future: NetworkBrain.quickPicks(),
        builder: (context, snapshot) {
          return BaseSnapshotControl(
            snapshot: snapshot,
            widget: SizedBox(
              height: 250,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  crossAxisCount: 1,
                  childAspectRatio: 0.7,
                ),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return RecommendedMusicVideosWidget(
                    d: d,
                    music: snapshot.data![index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter horizontalGridSectionSimilarTo(AppLocalizations d) {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<Musician>>(
        future: NetworkBrain.similarToMusician(),
        builder: (context, snapshot) {
          return BaseSnapshotControl(
              snapshot: snapshot,
              widget: SizedBox(
                height: 300,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    crossAxisCount: 1,
                    childAspectRatio: 2,
                  ),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return SimilarToWidget(
                      d: d,
                      musician: snapshot.data![index],
                    );
                  },
                ),
              ));
        },
      ),
    );
  }
}
