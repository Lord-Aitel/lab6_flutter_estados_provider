// lib/entity/actividad.dart

class Actividad {
  final int? id; // El ID es opcional porque la base de datos lo generará automáticamente al insertar
  final String fecha; // Guardaremos la fecha como un String (formato ISO 8601 es buena práctica)
  final String nombre;

  // Constructor de la clase
  Actividad({this.id, required this.fecha, required this.nombre});

  // Método para convertir un objeto Actividad a un Map.
  // Esto es necesario para guardar el objeto en la base de datos SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,       // Incluimos el ID si existe
      'fecha': fecha,
      'nombre': nombre,
    };
  }

  // Método de fábrica para crear un objeto Actividad desde un Map.
  // Esto es necesario para leer los datos de la base de datos SQLite y convertirlos de nuevo a objetos.
  factory Actividad.fromMap(Map<String, dynamic> map) {
    return Actividad(
      id: map['id'] as int?,       // El casting 'as int?' maneja IDs nulos
      fecha: map['fecha'] as String,
      nombre: map['nombre'] as String,
    );
  }

  // Opcional: Sobrescribir toString para una mejor representación del objeto al depurar
  @override
  String toString() {
    return 'Actividad(id: $id, fecha: $fecha, nombre: $nombre)';
  }
}