import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ¡Importante!
import 'provider/app_data.dart'; // ¡Importante!

class PreferenciasPage extends StatefulWidget {
  const PreferenciasPage({super.key});

  @override
  State<PreferenciasPage> createState() => _PreferenciasPageState();
}

class _PreferenciasPageState extends State<PreferenciasPage> {
  // Ya NO necesitamos _isResetEnabled, _loadPreferences(), _savePreferences() aquí.
  // AppData se encarga de todo eso.

  @override
  Widget build(BuildContext context) {
    // Usamos context.watch<AppData>() para escuchar los cambios en AppData
    // y reconstruir el widget si _canReset cambia.
    final appData = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: Center(
        child: SwitchListTile(
          title: const Text('Habilitar reinicio del contador'),
          value: appData.canReset, // Leemos el valor directamente de AppData
          onChanged: (value) {
            // Cuando el Switch cambia, llamamos al método setCanReset de AppData
            // AppData se encargará de actualizar su estado y guardarlo en SharedPreferences.
            appData.setCanReset(value);
          },
        ),
      ),
    );
  }
}