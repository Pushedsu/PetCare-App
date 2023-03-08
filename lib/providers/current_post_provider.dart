import 'package:flutter/material.dart';

class CurrentPostProvider with ChangeNotifier{
  String _objectId = '';
  String _title = '';
  String _name = '';
  String _contents = '';
  int _likeCount = 0;

  getLikeCount() => _likeCount;

  setLikeCount(int likeCount) {
    _likeCount = likeCount;
    notifyListeners();
  }

  getObjectId() => _objectId;

  setObjectId(String objectId) {
    _objectId = objectId;
    notifyListeners();
  }

  getTitle() => _title;

  setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  getName() => _name;

  setName(String name) {
    _name = name;
    notifyListeners();
  }

  getContents() => _contents;

  setContents(String contents) {
    _contents = contents;
    notifyListeners();
  }
}