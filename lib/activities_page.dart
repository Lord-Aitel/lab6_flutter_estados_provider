// lib/activities_page.dart
import 'package:flutter/material.dart';
import 'actividad.dart'; // Importa la clase Actividad que definimos
import 'database_helper.dart'; // Importa el DatabaseHelper para interactuar con la BD

class ActividadesPage extends StatefulWidget {
  const ActividadesPage({super.key});

  @override
  State<ActividadesPage> createState() => _ActividadesPageState();
}

class _ActividadesPageState extends State<ActividadesPage> {
  // Instancia de nuestro DatabaseHelper para realizar operaciones de BD
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Lista para almacenar las actividades que se recuperan de la base de datos
  List<Actividad> _activities = [];

  @override
  void initState() {
    super.initState();
    // Cuando la pantalla se inicializa, cargamos las actividades existentes
    _loadActivities();
  }

  // Método asíncrono para cargar todas las actividades desde la base de datos
  Future<void> _loadActivities() async {
    final activities = await _dbHelper.getActivities(); // Obtiene las actividades
    setState(() {
      _activities = activities; // Actualiza el estado para que la UI se reconstruya
    });
  }

  // Método para agregar una nueva actividad. Abre un diálogo para ingresar el nombre.
  Future<void> _addActivity() async {
    final TextEditingController nameController = TextEditingController(); // Controlador para el input
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Actividad'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Nombre de la actividad'),
            autofocus: true, // Para que el teclado aparezca automáticamente
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cierra el diálogo sin guardar
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  // Crea un nuevo objeto Actividad con la fecha actual y el nombre ingresado
                  final newActivity = Actividad(
                    fecha: DateTime.now().toIso8601String(), // Formato ISO 8601 para la fecha
                    nombre: nameController.text.trim(), // Elimina espacios en blanco al inicio/final
                  );
                  await _dbHelper.insertActivity(newActivity); // Inserta la actividad en la BD
                  await _loadActivities(); // Vuelve a cargar la lista para que la UI se actualice
                  if (mounted) Navigator.pop(context); // Cierra el diálogo después de guardar
                } else {
                  // Opcional: Mostrar un mensaje si el nombre está vacío
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('El nombre de la actividad no puede estar vacío.')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Método para editar una actividad existente. Abre un diálogo similar al de agregar.
  Future<void> _editActivity(Actividad activity) async {
    final TextEditingController nameController = TextEditingController(text: activity.nombre);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Actividad'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Nuevo nombre de actividad'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  // Crea un objeto Actividad actualizado, manteniendo el ID original
                  final updatedActivity = Actividad(
                    id: activity.id, // Es crucial mantener el ID para que la actualización funcione
                    fecha: activity.fecha, // Mantiene la fecha original
                    nombre: nameController.text.trim(),
                  );
                  await _dbHelper.updateActivity(updatedActivity); // Actualiza la actividad en la BD
                  await _loadActivities(); // Recarga la lista para actualizar la UI
                  if (mounted) Navigator.pop(context);
                } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('El nombre de la actividad no puede estar vacío.')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Método para eliminar una actividad. Muestra un diálogo de confirmación.
  Future<void> _deleteActivity(int id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que quieres eliminar esta actividad?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // No eliminar
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Confirmar eliminación
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _dbHelper.deleteActivity(id); // Elimina la actividad de la BD
      await _loadActivities(); // Recarga la lista para actualizar la UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Actividades'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Coherente con tu AppBar principal
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addActivity, // Botón para agregar una nueva actividad
            tooltip: 'Agregar nueva actividad',
          ),
        ],
      ),
      body: _activities.isEmpty // Si la lista de actividades está vacía
          ? const Center(
              child: Text('No hay actividades registradas aún.\nPresiona "+" para agregar una.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder( // Si hay actividades, construye una lista
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return Card( // Usamos Card para dar un mejor diseño a cada item
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 2,
                  child: ListTile(
                    title: Text(activity.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Fecha: ${activity.fecha.substring(0, 10)}', // Muestra solo la parte de la fecha
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Para que los iconos no ocupen todo el espacio
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editActivity(activity), // Botón para editar
                          tooltip: 'Editar actividad',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteActivity(activity.id!), // Botón para eliminar
                          tooltip: 'Eliminar actividad',
                        ),
                      ],
                    ),
                    onTap: () {
                      // Opcional: Podrías navegar a una pantalla de detalles o hacer algo al tocar el item
                    },
                  ),
                );
              },
            ),
    );
  }
}