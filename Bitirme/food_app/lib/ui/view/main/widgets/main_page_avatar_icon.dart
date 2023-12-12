import 'package:flutter/material.dart';
import 'package:food_app/data/utils/preference_service.dart';
import 'package:food_app/ui/view/profile/profile_page.dart';

class MainPageAvatarIcon extends StatelessWidget {
  const MainPageAvatarIcon({
    super.key,
    required this.prefs,
  });

  final PreferencesService prefs;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProfilePage();
            },
          ),
        );
      },
      icon: CircleAvatar(
        backgroundImage: NetworkImage(prefs.imageURL),
      ),
    );
  }
}
