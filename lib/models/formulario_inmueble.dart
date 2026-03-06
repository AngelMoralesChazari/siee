/// Modelo de datos del formulario (según apartados del PDF).
/// Ajusta los campos cuando tengas la lista exacta del documento.
class FormularioInmueble {
  String? id;
  final String nombreInmueble;
  final String calleYNumero;
  final String colonia;
  final String ciudad;
  final String estado;
  final String codigoPostal;
  final String? referencia;
  final String? observaciones;
  final DateTime fechaRegistro;

  FormularioInmueble({
    this.id,
    required this.nombreInmueble,
    required this.calleYNumero,
    required this.colonia,
    required this.ciudad,
    required this.estado,
    required this.codigoPostal,
    this.referencia,
    this.observaciones,
    DateTime? fechaRegistro,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'nombreInmueble': nombreInmueble,
      'calleYNumero': calleYNumero,
      'colonia': colonia,
      'ciudad': ciudad,
      'estado': estado,
      'codigoPostal': codigoPostal,
      'referencia': referencia,
      'observaciones': observaciones,
      'fechaRegistro': fechaRegistro.toIso8601String(),
    };
  }

  factory FormularioInmueble.fromMap(String id, Map<dynamic, dynamic> map) {
    return FormularioInmueble(
      id: id,
      nombreInmueble: map['nombreInmueble']?.toString() ?? '',
      calleYNumero: map['calleYNumero']?.toString() ?? '',
      colonia: map['colonia']?.toString() ?? '',
      ciudad: map['ciudad']?.toString() ?? '',
      estado: map['estado']?.toString() ?? '',
      codigoPostal: map['codigoPostal']?.toString() ?? '',
      referencia: map['referencia']?.toString(),
      observaciones: map['observaciones']?.toString(),
      fechaRegistro: map['fechaRegistro'] != null
          ? DateTime.tryParse(map['fechaRegistro'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
