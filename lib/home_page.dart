import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/app_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    // Constructor
    debugPrint("Constructor");
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  void deactivate() {
    super.deactivate();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void reassemble() {
    super.reassemble();
  }
  @override
  Widget build(BuildContext context) {

    final appData = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(
  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  title: Text('${widget.title} - ${appData.username}'),
  actions: [
  ],
),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bienvenido: ${appData.username}'),
            const Text('Contador:'),
            Text(
              '${appData.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: appData.incrementCounter,
                  child: const Text("+"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: appData.decrementCounter,
                  child: const Text("-"),
                ),
                const SizedBox(width: 10),
                if (appData.canReset)
                  ElevatedButton(
                    onPressed: appData.resetCounter,
                    child: const Text("Reiniciar"),
                  ),
              ],
            ),
          ],
        ),
      ),
            drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 156, 33, 243)),
              child: Text('Menú de Navegación', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            ListTile(
              title: const Text('About'),
              onTap: () => Navigator.pushNamed(context, '/about'),
            ),
            ListTile(
              title: const Text('Preferencias'),
              onTap: () => Navigator.pushNamed(context, '/preferencias'),
            ),
            ListTile(
              title: const Text('Actividades'),
              onTap: () => Navigator.pushNamed(context, '/actividades'),
            ),
          ],
        ),
      ),
    );
  }
}