import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  String _username = "Usuario";
  bool _canReset = true;

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

  void setCanReset(bool value) {
    _canReset = value;
    notifyListeners();
  }
}
