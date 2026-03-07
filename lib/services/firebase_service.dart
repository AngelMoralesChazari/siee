import 'package:firebase_database/firebase_database.dart';
import '../models/evaluacion_estructural.dart';

/// Servicio para Firebase Realtime Database (evaluaciones estructurales Bloque 1).
class FirebaseService {
  static const String _nodoEvaluaciones = 'evaluaciones';

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  /// Guarda un formulario Bloque 1 en Realtime Database.
  Future<String?> guardarEvaluacion(EvaluacionBloque1 datos) async {
    try {
      final nuevoRef = _ref.child(_nodoEvaluaciones).push();
      await nuevoRef.set(datos.toMap());
      return nuevoRef.key;
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene todas las evaluaciones (Bloque 1).
  Stream<List<EvaluacionBloque1>> obtenerEvaluaciones() {
    return _ref.child(_nodoEvaluaciones).onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <EvaluacionBloque1>[];
      final map = data as Map<dynamic, dynamic>;
      return map.entries.map((e) {
        return EvaluacionBloque1.fromMap(
          e.key.toString(),
          Map<dynamic, dynamic>.from(e.value as Map),
        );
      }).toList()
        ..sort((a, b) {
          final fa = a.fechaRegistro ?? DateTime(0);
          final fb = b.fechaRegistro ?? DateTime(0);
          return fb.compareTo(fa);
        });
    });
  }

  /// Elimina una evaluación por id.
  Future<void> eliminarEvaluacion(String id) async {
    await _ref.child(_nodoEvaluaciones).child(id).remove();
  }
}
