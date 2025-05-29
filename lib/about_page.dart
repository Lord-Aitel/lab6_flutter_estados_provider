import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/app_data.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final currentName = context.read<AppData>().username;
    _nameController = TextEditingController(text: currentName);
    //print('initState');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
    //print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();
    //print('build');
    return Scaffold(
      appBar: AppBar(title: const Text("Detalles del Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Editar nombre del usuario:"),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => appData.updateUsername(value),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text("¿Permitir reiniciar contador?"),
              value: appData.canReset,
              onChanged: (value) => appData.setCanReset(value),
            ),
          ],
        ),
      ),
    );
  }
}
