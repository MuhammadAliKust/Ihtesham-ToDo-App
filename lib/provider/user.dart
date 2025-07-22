import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String _name = "";

  void setName(String val) {
    _name = val;
    notifyListeners();
  }

  String getName() => _name;
}
