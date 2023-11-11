import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier{
  String _objId = '';
  String _name = '';
  String _imgUrl = '';

  getObjId() => _objId;

  setObjId(String objId) {
    _objId = objId;
    notifyListeners();
  }

  getName() => _name;

  setName(String name) {
    _name = name;
    notifyListeners();
  }

  getImgUrl() => _imgUrl;

  setImgUrl(String imgUrl) {
    _imgUrl = imgUrl;
    notifyListeners();
  }
}