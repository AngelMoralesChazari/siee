import '../models/formulario_inmueble.dart';

/// Servicio Firebase desactivado temporalmente (paquetes comentados en pubspec).
/// Para reactivar: descomenta firebase_core y firebase_database en pubspec.yaml,
/// llama a Firebase.initializeApp() en main.dart y restaura la implementación
/// real (ver firebase_service_impl.dart.backup si la guardamos, o reescribir).
class FirebaseService {
  Future<String?> guardarFormulario(FormularioInmueble formulario) async => null;
  Stream<List<FormularioInmueble>> obtenerFormularios() => Stream.value([]);
  Future<void> eliminarFormulario(String id) async {}
}
