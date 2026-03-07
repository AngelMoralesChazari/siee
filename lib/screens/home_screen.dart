import 'package:flutter/material.dart';
import '../models/evaluacion_estructural.dart';
import '../services/firebase_service.dart';
import 'formulario_evaluacion_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIEE'),
      ),
      body: StreamBuilder<List<EvaluacionBloque1>>(
        stream: firebaseService.obtenerEvaluaciones(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            );
          }
          final lista = snapshot.data ?? [];
          if (lista.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No hay evaluaciones a\u00fan',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Toca el bot\u00f3n + para agregar una',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final item = lista[index];
              final nombre = item.nombreInmueble.trim().isNotEmpty
                  ? item.nombreInmueble
                  : 'Sin nombre';
              final subtitulo = item.calleYNumero.trim().isNotEmpty
                  ? '${item.calleYNumero}${item.colonia.trim().isNotEmpty ? ", ${item.colonia}" : ""}'
                  : (item.colonia.trim().isNotEmpty ? item.colonia : '');
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(nombre),
                  subtitle: subtitulo.isNotEmpty ? Text(subtitulo) : null,
                  trailing: item.id != null
                      ? IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _confirmarEliminar(context, firebaseService, item),
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const FormularioEvaluacionScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _confirmarEliminar(
    BuildContext context,
    FirebaseService service,
    EvaluacionBloque1 item,
  ) async {
    final nombre = item.nombreInmueble.trim().isNotEmpty ? item.nombreInmueble : 'esta evaluaci\u00f3n';
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar'),
        content: Text('\u00bfEliminar "$nombre"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (ok == true && item.id != null) {
      await service.eliminarEvaluacion(item.id!);
    }
  }
}
