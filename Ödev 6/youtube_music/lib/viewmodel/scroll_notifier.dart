import 'package:flutter/material.dart';

class ScrollNotifier with ChangeNotifier {
  bool _isScrolled = false;

  bool get isScrolled => _isScrolled;

  void updateScroll(bool isScrolled) {
    _isScrolled = isScrolled;
    notifyListeners();
  }
}
