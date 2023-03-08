import 'package:flutter/cupertino.dart';

class OnOffProvider extends ChangeNotifier{

  bool _change = false;

  bool get change => _change;

  void onOff() {
    if(_change == true) {
      _change = false;
    } else {
      _change = true;
    }
    notifyListeners();
  }
}