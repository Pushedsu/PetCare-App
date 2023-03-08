import 'package:flutter/material.dart';

class PageIndexProvider with ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  setPageIndex(int pageIndex) {
    _pageIndex = pageIndex;
    notifyListeners();
  }

}