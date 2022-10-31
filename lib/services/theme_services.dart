import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  bool _loadThemeFromBox() {
    if (_box.read(_key)) {
      return true;
    } else {
      return false;
    }
  }

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
  }
}
