import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  late SharedPreferences _prefs;

  PreferencesService._privateConstructor();

  static final PreferencesService _instance =
      PreferencesService._privateConstructor();

  factory PreferencesService() {
    return _instance;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get seenOnboard => _prefs.getBool('seenOnboard') ?? false;

  Future<void> setSeenOnboard(bool value) async {
    await _prefs.setBool('seenOnboard', value);
    await _prefs.reload();
  }

  String get username => _prefs.getString('username') ?? '';

  Future<void> setUsername(String username) async {
    await _prefs.setString('username', username);
    await _prefs.reload();
  }

  String get email => _prefs.getString('email') ?? '';

  Future<void> setEmail(String email) async {
    await _prefs.setString('email', email);
    await _prefs.reload();
  }

  String get userId => _prefs.getString('id') ?? '';

  Future<void> setUserId(String userId) async {
    await _prefs.setString('id', userId);
    await _prefs.reload();
  }

  String get imageURL => _prefs.getString('imageURL') ?? '';

  Future<void> setImageURL(String url) async {
    await _prefs.setString('imageURL', url);
    await _prefs.reload();
  }
}
