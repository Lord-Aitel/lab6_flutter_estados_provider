// lib/services/database_helper.dart

import 'package:sqflite/sqflite.dart'; // Importa el paquete sqflite
import 'package:path/path.dart';     // Importa path para manejar rutas de archivos
import 'actividad.dart';  // ¡Importa tu clase Actividad! (Ruta relativa)

class DatabaseHelper {
  // Patrón Singleton: Asegura que solo haya una instancia de DatabaseHelper en toda la aplicación.
  // Esto es crucial para gestionar la única conexión a la base de datos.
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database; // La instancia de la base de datos

  // Constructor de fábrica que siempre devuelve la misma instancia Singleton.
  factory DatabaseHelper() {
    return _instance;
  }

  // Constructor interno privado para el Singleton.
  DatabaseHelper._internal();

  // Getter para obtener la instancia de la base de datos.
  // Si la base de datos ya existe, la devuelve; si no, la inicializa.
  Future<Database> get database async {
    if (_database != null) {
      return _database!; // Si _database no es nulo, lo devuelve
    }
    _database = await _initDatabase(); // Si es nulo, lo inicializa
    return _database!;
  }

  // Inicializa la base de datos.
  // Esto implica obtener la ruta de la base de datos y abrirla (o crearla si no existe).
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath(); // Obtiene la ruta estándar para las bases de datos en el dispositivo
    final path = join(dbPath, 'activity_database.db'); // Define el nombre de tu archivo de base de datos

    return await openDatabase(
      path,           // Ruta completa al archivo de la base de datos
      version: 1,     // Versión de la base de datos (útil para futuras migraciones)
      onCreate: _onCreate, // Callback que se ejecuta la primera vez que se crea la base de datos
    );
  }

  // Método _onCreate: Define el esquema de la base de datos (crea tablas).
  // Se llama solo cuando la base de datos se crea por primera vez.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE activities(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fecha TEXT NOT NULL,
        nombre TEXT NOT NULL
      )
    ''');
    // Esto crea una tabla llamada 'activities' con tres columnas:
    // - id: Número entero, clave primaria, autoincremental (se genera automáticamente).
    // - fecha: Texto (usaremos ISO 8601 para guardar fechas).
    // - nombre: Texto.
  }

  // --- Operaciones CRUD (Create, Read, Update, Delete) ---

  // Crea (Insertar) una nueva actividad en la base de datos.
  Future<void> insertActivity(Actividad activity) async {
    final db = await database; // Obtiene la instancia de la base de datos
    await db.insert(
      'activities',           // Nombre de la tabla
      activity.toMap(),       // Convierte el objeto Actividad a un Map para la inserción
      conflictAlgorithm: ConflictAlgorithm.replace, // Si el ID ya existe, reemplaza el registro
    );
  }

  // Leer (Obtener) todas las actividades de la base de datos.
  Future<List<Actividad>> getActivities() async {
    final db = await database;
    // Consulta todos los registros de la tabla 'activities'.
    final List<Map<String, dynamic>> maps = await db.query('activities');

    // Convierte la List<Map<String, dynamic>> (resultado de la consulta)
    // a una List<Actividad>.
    return List.generate(maps.length, (i) {
      return Actividad.fromMap(maps[i]);
    });
  }

  // Actualizar una actividad existente en la base de datos.
  Future<void> updateActivity(Actividad activity) async {
    final db = await database;
    await db.update(
      'activities',           // Nombre de la tabla
      activity.toMap(),       // El objeto Actividad actualizado convertido a Map
      where: 'id = ?',        // Cláusula WHERE para especificar qué registro actualizar (por ID)
      whereArgs: [activity.id], // Los argumentos para la cláusula WHERE
    );
  }

  // Eliminar una actividad de la base de datos por su ID.
  Future<void> deleteActivity(int id) async {
    final db = await database;
    await db.delete(
      'activities',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}