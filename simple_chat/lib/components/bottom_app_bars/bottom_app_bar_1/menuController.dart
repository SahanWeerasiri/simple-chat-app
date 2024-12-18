import 'package:flutter/material.dart';

class CustomMenuController {
  int _currentIndex = 0;
  List<Widget> pages;
  void setCurrentIndex(int index) {
    _currentIndex = index;
  }

  int getCurrentIndex() {
    return _currentIndex;
  }

  CustomMenuController(
    this._currentIndex,
    this.pages,
  ) {
    _currentIndex = 0;
  }
}
