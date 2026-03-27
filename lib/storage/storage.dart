import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme extends ChangeNotifier {
  var isDarkMode = false;

  void changeTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
