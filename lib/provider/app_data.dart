import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

class AppData extends ChangeNotifier {
  int _counter = 0;
  String _username = "Usuario";
  bool _canReset = false; 


  AppData() {
    _loadCanResetPreference();
  }

  int get counter => _counter;
  String get username => _username;
  bool get canReset => _canReset; 

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }

  void resetCounter() {
    if (_canReset) { 
      _counter = 0;
      notifyListeners();
    }
  }

  void updateUsername(String name) {
    _username = name;
    notifyListeners();
  }


  Future<void> setCanReset(bool value) async {
    _canReset = value;
    notifyListeners(); 

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isResetEnabled', value); 
  }
  Future<void> _loadCanResetPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _canReset = prefs.getBool('isResetEnabled') ?? false; 
    notifyListeners(); 
  }
}