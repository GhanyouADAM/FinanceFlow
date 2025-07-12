
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeColorService{
  static const String _colorKey = 'theme_color';

  //color saving
Future<void> saveColor(Color color) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_colorKey, color.value);
}

//read from file the saved color
Future<Color> getSavedColor() async {
  final prefs = await SharedPreferences.getInstance();
  final colorValue = prefs.getInt(_colorKey);
  return colorValue != null ? Color(colorValue) :  Color.fromARGB(255, 179, 38, 197);
}
}