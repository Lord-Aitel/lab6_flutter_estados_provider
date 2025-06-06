import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/app_data.dart';
import 'about_page.dart';
//import 'home_Page.dart'; // No se necesita si MyHomePage está en el mismo archivo
import 'preferences_page.dart';
import 'activities_page.dart';
import 'database_helper.dart'; 

void main() async { 

  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa la base de datos.
  await DatabaseHelper().database; 

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
      title: 'Lab 8 - Obtención de imágenes desde internet ', 
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Lab 8'), 
      routes: {
        '/home': (context) => const MyHomePage(title: 'Lab 7'),
        '/about': (context) => const AboutPage(),
        '/preferencias': (context) => const PreferenciasPage(),
        '/actividades': (context) => const ActividadesPage(), 
      },
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
        actions: const [
          // Puedes añadir acciones aquí si las necesitas
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
            Image.network(
              'https://cdna.artstation.com/p/assets/images/images/056/119/340/large/alex-figini-hakke-titan-armour-05.jpg?1668509505',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Error al cargar imagen', style: TextStyle(color: Colors.red));
              },
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
                // El botón de Reiniciar se muestra si appData.canReset es true
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
      drawer: Drawer( // Menú de acceso a las pantallas 
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
              onTap: () {
                Navigator.pushNamed(context, '/preferencias');
              },
            ),
            ListTile(
              title: const Text('Actividades'),
              onTap: () => Navigator.pushNamed(context, '/actividades'),
            ),
          ],
        ),
      ),
      // /*floatingActionButton: FloatingActionButton(
      //   onPressed: appData.incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),*///boton que ya no sirve ni se usa
    );
  }
}