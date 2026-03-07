/// Modelo del Bloque 1: INFORMACIÓN GENERAL (evaluación estructural).
class EvaluacionBloque1 {
  /// Id en Firebase (cuando se carga desde la BD).
  String? id;

  // --- Datos básicos ---
  DateTime? fecha;
  String coordenadas;
  String nombreInmueble;
  String calleYNumero;
  String colonia;
  String codigoPostal;
  String puebloCiudad;
  String municipioAlcaldia;
  String estado;
  String referencias;
  String contacto;
  String telefono;

  // --- Sección 1: Uso ---
  bool usoVivienda;
  bool usoHospital;
  bool usoOficinas;
  bool usoIglesia;
  bool usoComercio;
  bool usoReunion;
  bool usoEscuela;
  bool usoIndustrial;
  String usoOtro;
  bool desocupada;

  // --- Sección 2 ---
  int? numeroNiveles;
  int? numeroSotanos;
  int? pisosEstacionamiento;
  int? numeroOcupantes;
  bool elevador;
  bool escaleraEmergencia;
  int? anioConstruccion;
  int? anioDanoSevero;
  int? anioRehabilitacion;
  double? dimensionFrenteX;
  double? dimensionFondoY;

  /// Fecha de registro (al guardar en Firebase).
  DateTime? fechaRegistro;

  // --- Sección 3: Topografía ---
  bool topografiaPlanicie;
  bool topografiaLadera;
  bool topografiaRivera;
  bool topografiaFondoValle;
  bool topografiaDepositosLacustres;
  bool topografiaCosta;

  EvaluacionBloque1({
    this.id,
    this.fecha,
    this.fechaRegistro,
    this.coordenadas = '',
    this.nombreInmueble = '',
    this.calleYNumero = '',
    this.colonia = '',
    this.codigoPostal = '',
    this.puebloCiudad = '',
    this.municipioAlcaldia = '',
    this.estado = '',
    this.referencias = '',
    this.contacto = '',
    this.telefono = '',
    this.usoVivienda = false,
    this.usoHospital = false,
    this.usoOficinas = false,
    this.usoIglesia = false,
    this.usoComercio = false,
    this.usoReunion = false,
    this.usoEscuela = false,
    this.usoIndustrial = false,
    this.usoOtro = '',
    this.desocupada = false,
    this.numeroNiveles,
    this.numeroSotanos,
    this.pisosEstacionamiento,
    this.numeroOcupantes,
    this.elevador = false,
    this.escaleraEmergencia = false,
      this.anioConstruccion,
      this.anioDanoSevero,
      this.anioRehabilitacion,
    this.dimensionFrenteX,
    this.dimensionFondoY,
    this.topografiaPlanicie = false,
    this.topografiaLadera = false,
    this.topografiaRivera = false,
    this.topografiaFondoValle = false,
    this.topografiaDepositosLacustres = false,
    this.topografiaCosta = false,
  });

  bool get tieneAlgunDatoBasico =>
      fecha != null ||
      coordenadas.trim().isNotEmpty ||
      nombreInmueble.trim().isNotEmpty ||
      calleYNumero.trim().isNotEmpty ||
      colonia.trim().isNotEmpty ||
      codigoPostal.trim().isNotEmpty ||
      puebloCiudad.trim().isNotEmpty ||
      municipioAlcaldia.trim().isNotEmpty ||
      estado.trim().isNotEmpty ||
      referencias.trim().isNotEmpty ||
      contacto.trim().isNotEmpty ||
      telefono.trim().isNotEmpty;

  bool get tieneAlgunUso =>
      usoVivienda ||
      usoHospital ||
      usoOficinas ||
      usoIglesia ||
      usoComercio ||
      usoReunion ||
      usoEscuela ||
      usoIndustrial ||
      usoOtro.trim().isNotEmpty ||
      desocupada;

  bool get tieneAlgunDatoSeccion2 =>
      numeroNiveles != null ||
      numeroSotanos != null ||
      pisosEstacionamiento != null ||
      numeroOcupantes != null ||
      elevador ||
      escaleraEmergencia ||
      anioConstruccion != null ||
      anioDanoSevero != null ||
      anioRehabilitacion != null ||
      dimensionFrenteX != null ||
      dimensionFondoY != null;

  bool get tieneAlgunaTopografia =>
      topografiaPlanicie ||
      topografiaLadera ||
      topografiaRivera ||
      topografiaFondoValle ||
      topografiaDepositosLacustres ||
      topografiaCosta;

  /// Para guardar en Firebase Realtime Database.
  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha?.toIso8601String(),
      'coordenadas': coordenadas,
      'nombreInmueble': nombreInmueble,
      'calleYNumero': calleYNumero,
      'colonia': colonia,
      'codigoPostal': codigoPostal,
      'puebloCiudad': puebloCiudad,
      'municipioAlcaldia': municipioAlcaldia,
      'estado': estado,
      'referencias': referencias,
      'contacto': contacto,
      'telefono': telefono,
      'usoVivienda': usoVivienda,
      'usoHospital': usoHospital,
      'usoOficinas': usoOficinas,
      'usoIglesia': usoIglesia,
      'usoComercio': usoComercio,
      'usoReunion': usoReunion,
      'usoEscuela': usoEscuela,
      'usoIndustrial': usoIndustrial,
      'usoOtro': usoOtro,
      'desocupada': desocupada,
      'numeroNiveles': numeroNiveles,
      'numeroSotanos': numeroSotanos,
      'pisosEstacionamiento': pisosEstacionamiento,
      'numeroOcupantes': numeroOcupantes,
      'elevador': elevador,
      'escaleraEmergencia': escaleraEmergencia,
      'anioConstruccion': anioConstruccion,
      'anioDanoSevero': anioDanoSevero,
      'anioRehabilitacion': anioRehabilitacion,
      'dimensionFrenteX': dimensionFrenteX,
      'dimensionFondoY': dimensionFondoY,
      'topografiaPlanicie': topografiaPlanicie,
      'topografiaLadera': topografiaLadera,
      'topografiaRivera': topografiaRivera,
      'topografiaFondoValle': topografiaFondoValle,
      'topografiaDepositosLacustres': topografiaDepositosLacustres,
      'topografiaCosta': topografiaCosta,
      'fechaRegistro': DateTime.now().toIso8601String(),
    };
  }

  /// Desde Firebase Realtime Database.
  static EvaluacionBloque1 fromMap(String id, Map<dynamic, dynamic> map) {
    final m = Map<String, dynamic>.from(map);
    final fechaReg = m['fechaRegistro'] != null
        ? DateTime.tryParse(m['fechaRegistro'].toString())
        : null;
    return EvaluacionBloque1(
      id: id,
      fechaRegistro: fechaReg,
      fecha: m['fecha'] != null ? DateTime.tryParse(m['fecha'].toString()) : null,
      coordenadas: m['coordenadas']?.toString() ?? '',
      nombreInmueble: m['nombreInmueble']?.toString() ?? '',
      calleYNumero: m['calleYNumero']?.toString() ?? '',
      colonia: m['colonia']?.toString() ?? '',
      codigoPostal: m['codigoPostal']?.toString() ?? '',
      puebloCiudad: m['puebloCiudad']?.toString() ?? '',
      municipioAlcaldia: m['municipioAlcaldia']?.toString() ?? '',
      estado: m['estado']?.toString() ?? '',
      referencias: m['referencias']?.toString() ?? '',
      contacto: m['contacto']?.toString() ?? '',
      telefono: m['telefono']?.toString() ?? '',
      usoVivienda: m['usoVivienda'] == true,
      usoHospital: m['usoHospital'] == true,
      usoOficinas: m['usoOficinas'] == true,
      usoIglesia: m['usoIglesia'] == true,
      usoComercio: m['usoComercio'] == true,
      usoReunion: m['usoReunion'] == true,
      usoEscuela: m['usoEscuela'] == true,
      usoIndustrial: m['usoIndustrial'] == true,
      usoOtro: m['usoOtro']?.toString() ?? '',
      desocupada: m['desocupada'] == true,
      numeroNiveles: _int(m['numeroNiveles']),
      numeroSotanos: _int(m['numeroSotanos']),
      pisosEstacionamiento: _int(m['pisosEstacionamiento']),
      numeroOcupantes: _int(m['numeroOcupantes']),
      elevador: m['elevador'] == true,
      escaleraEmergencia: m['escaleraEmergencia'] == true,
      anioConstruccion: _int(m['anioConstruccion']),
      anioDanoSevero: _int(m['anioDanoSevero']),
      anioRehabilitacion: _int(m['anioRehabilitacion']),
      dimensionFrenteX: _double(m['dimensionFrenteX']),
      dimensionFondoY: _double(m['dimensionFondoY']),
      topografiaPlanicie: m['topografiaPlanicie'] == true,
      topografiaLadera: m['topografiaLadera'] == true,
      topografiaRivera: m['topografiaRivera'] == true,
      topografiaFondoValle: m['topografiaFondoValle'] == true,
      topografiaDepositosLacustres: m['topografiaDepositosLacustres'] == true,
      topografiaCosta: m['topografiaCosta'] == true,
    );
  }

  static int? _int(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    return int.tryParse(v.toString());
  }

  static double? _double(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString().replaceAll(',', '.'));
  }

  EvaluacionBloque1 copyWith({
    String? id,
    DateTime? fecha,
    DateTime? fechaRegistro,
    String? coordenadas,
    String? nombreInmueble,
    String? calleYNumero,
    String? colonia,
    String? codigoPostal,
    String? puebloCiudad,
    String? municipioAlcaldia,
    String? estado,
    String? referencias,
    String? contacto,
    String? telefono,
    bool? usoVivienda,
    bool? usoHospital,
    bool? usoOficinas,
    bool? usoIglesia,
    bool? usoComercio,
    bool? usoReunion,
    bool? usoEscuela,
    bool? usoIndustrial,
    String? usoOtro,
    bool? desocupada,
    int? numeroNiveles,
    int? numeroSotanos,
    int? pisosEstacionamiento,
    int? numeroOcupantes,
    bool? elevador,
    bool? escaleraEmergencia,
    int? anioConstruccion,
    int? anioDanoSevero,
    int? anioRehabilitacion,
    double? dimensionFrenteX,
    double? dimensionFondoY,
    bool? topografiaPlanicie,
    bool? topografiaLadera,
    bool? topografiaRivera,
    bool? topografiaFondoValle,
    bool? topografiaDepositosLacustres,
    bool? topografiaCosta,
  }) {
    return EvaluacionBloque1(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      coordenadas: coordenadas ?? this.coordenadas,
      nombreInmueble: nombreInmueble ?? this.nombreInmueble,
      calleYNumero: calleYNumero ?? this.calleYNumero,
      colonia: colonia ?? this.colonia,
      codigoPostal: codigoPostal ?? this.codigoPostal,
      puebloCiudad: puebloCiudad ?? this.puebloCiudad,
      municipioAlcaldia: municipioAlcaldia ?? this.municipioAlcaldia,
      estado: estado ?? this.estado,
      referencias: referencias ?? this.referencias,
      contacto: contacto ?? this.contacto,
      telefono: telefono ?? this.telefono,
      usoVivienda: usoVivienda ?? this.usoVivienda,
      usoHospital: usoHospital ?? this.usoHospital,
      usoOficinas: usoOficinas ?? this.usoOficinas,
      usoIglesia: usoIglesia ?? this.usoIglesia,
      usoComercio: usoComercio ?? this.usoComercio,
      usoReunion: usoReunion ?? this.usoReunion,
      usoEscuela: usoEscuela ?? this.usoEscuela,
      usoIndustrial: usoIndustrial ?? this.usoIndustrial,
      usoOtro: usoOtro ?? this.usoOtro,
      desocupada: desocupada ?? this.desocupada,
      numeroNiveles: numeroNiveles ?? this.numeroNiveles,
      numeroSotanos: numeroSotanos ?? this.numeroSotanos,
      pisosEstacionamiento: pisosEstacionamiento ?? this.pisosEstacionamiento,
      numeroOcupantes: numeroOcupantes ?? this.numeroOcupantes,
      elevador: elevador ?? this.elevador,
      escaleraEmergencia: escaleraEmergencia ?? this.escaleraEmergencia,
      anioConstruccion: anioConstruccion ?? this.anioConstruccion,
      anioDanoSevero: anioDanoSevero ?? this.anioDanoSevero,
      anioRehabilitacion: anioRehabilitacion ?? this.anioRehabilitacion,
      dimensionFrenteX: dimensionFrenteX ?? this.dimensionFrenteX,
      dimensionFondoY: dimensionFondoY ?? this.dimensionFondoY,
      topografiaPlanicie: topografiaPlanicie ?? this.topografiaPlanicie,
      topografiaLadera: topografiaLadera ?? this.topografiaLadera,
      topografiaRivera: topografiaRivera ?? this.topografiaRivera,
      topografiaFondoValle: topografiaFondoValle ?? this.topografiaFondoValle,
      topografiaDepositosLacustres: topografiaDepositosLacustres ?? this.topografiaDepositosLacustres,
      topografiaCosta: topografiaCosta ?? this.topografiaCosta,
    );
  }
}
