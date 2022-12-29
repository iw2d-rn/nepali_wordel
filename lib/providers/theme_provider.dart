import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier{
  bool isDark=false;

  // setTheme(){
  setTheme({required bool turnOn}){
    // isDark=!isDark;
    isDark=turnOn;
    // notifyListeners();
    notifyListeners();
  }
}