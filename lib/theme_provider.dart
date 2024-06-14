import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  Brightness _theme=Brightness.light;
  
  Brightness get theme=>_theme;

  void setThemeMode(Brightness mode){
    _theme=mode;
    notifyListeners();
  }
}