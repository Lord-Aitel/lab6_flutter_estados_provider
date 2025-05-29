import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa shared_preferences

class AppData extends ChangeNotifier {
  int _counter = 0;
  String _username = "Usuario";
  bool _canReset = false; // Inicializa a false por defecto o un valor seguro.

  // Constructor: Carga las preferencias cuando la AppData se inicializa
  AppData() {
    _loadCanResetPreference();
  }

  int get counter => _counter;
  String get username => _username;
  bool get canReset => _canReset; // Getter para la preferencia

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

  // Método para actualizar y guardar la preferencia
  Future<void> setCanReset(bool value) async {
    _canReset = value;
    notifyListeners(); // Notifica a los listeners inmediatamente

    // Guarda el valor en SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isResetEnabled', value); // Guarda con la clave 'isResetEnabled' [cite: 21]
  }

  // Método para cargar la preferencia al inicio
  Future<void> _loadCanResetPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _canReset = prefs.getBool('isResetEnabled') ?? false; // Carga el valor, si no existe, por defecto es false [cite: 20]
    notifyListeners(); // Notifica a los listeners después de cargar la preferencia [cite: 24]
  }
}