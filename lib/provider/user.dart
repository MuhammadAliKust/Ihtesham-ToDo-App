import 'package:flutter/widgets.dart';
import 'package:ihtesham_project/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  void setUser(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  UserModel? getUser() => _userModel;
}
