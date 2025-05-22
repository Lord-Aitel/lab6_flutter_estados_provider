import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/app_data.dart';
import 'about_page.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppData(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6 - Estados y Provider',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Lab 6'),
    );
  }
}
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
    IconButton(
      icon: const Icon(Icons.info_outline),
      tooltip: 'Ir a detalles',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AboutPage()),
        );
      },
    )
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
      /*floatingActionButton: FloatingActionButton(
        onPressed: appData.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*///boton que ya no sirve ni se usa
    );
  }
}
