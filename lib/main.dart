import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/app_data.dart';
import 'about_page.dart';
//import 'Home_Page.dart'; // No se necesita si MyHomePage está en el mismo archivo
import 'preferences_page.dart';
import 'activities_page.dart';
import 'database_helper.dart'; // ¡Importación corregida! Asegúrate de que sea 'services/database_helper.dart'


// MODIFICACIÓN CLAVE: main() debe ser async y contener la inicialización de la base de datos
void main() async { // Convertir main a async [cite: 53]
  // Asegura que los bindings de Flutter estén inicializados.
  // Esto es crucial para usar plugins (como sqflite) antes de llamar a runApp(). [cite: 40]
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa la base de datos.
  // Llama al getter 'database' de DatabaseHelper que se encarga de abrir o crear la BD. [cite: 54]
  await DatabaseHelper().database; // o .initializeDatabase() si defines un método así [cite: 54]

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
      title: 'Lab 7 - Persistencia de Datos', // Título más descriptivo para el Lab 7
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Lab 7'), // Establece la página de inicio
      routes: {
        '/home': (context) => const MyHomePage(title: 'Lab 7'),
        '/about': (context) => const AboutPage(),
        '/preferencias': (context) => const PreferenciasPage(),
        '/actividades': (context) => const ActividadesPage(), // Esta ruta ya está bien definida
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    // Eliminado el mensaje asociado a createState para evitar warnings. [cite: 8]
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    // Constructor. Eliminado el debugPrint según las instrucciones del lab. [cite: 8]
  }

  @override
  void initState() {
    super.initState();
    // La carga de preferencias ahora la maneja AppData en su constructor.
    // Si necesitas alguna carga específica aquí para MyHomePage, la agregarías.
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
      drawer: Drawer( // Menú de acceso a las pantallas [cite: 9]
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
                // No se necesita .then((_) => ...) aquí, ya que AppData notifica los cambios.
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