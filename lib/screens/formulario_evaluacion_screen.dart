import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/evaluacion_estructural.dart';
import '../services/firebase_service.dart';

/// Bloque 1: INFORMACIÓN GENERAL (datos básicos + Sección 1, 2, 3).
class FormularioEvaluacionScreen extends StatefulWidget {
  const FormularioEvaluacionScreen({super.key});

  @override
  State<FormularioEvaluacionScreen> createState() =>
      _FormularioEvaluacionScreenState();
}

class _FormularioEvaluacionScreenState extends State<FormularioEvaluacionScreen> {
  static const int _totalPasos = 4; // 0: datos básicos, 1: sección 1, 2: sección 2, 3: sección 3
  int _pasoActual = 0;
  bool _guardando = false;

  late EvaluacionBloque1 _datos;
  final _controllers = <String, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    _datos = EvaluacionBloque1();
    _crearControllers();
  }

  void _crearControllers() {
    final keys = [
      'coordenadasN', 'coordenadasO', 'nombreInmueble', 'calleYNumero', 'colonia', 'codigoPostal',
      'puebloCiudad', 'municipioAlcaldia', 'estado', 'referencias', 'contacto', 'telefono',
      'usoOtro',
      'numeroNiveles', 'numeroSotanos', 'pisosEstacionamiento', 'numeroOcupantes',
      'anioConstruccion', 'anioDanoSevero', 'anioRehabilitacion', 'dimensionFrenteX', 'dimensionFondoY',
    ];
    for (final k in keys) {
      _controllers[k] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _sincronizarDatosBasicos() {
    _datos = EvaluacionBloque1(
      fecha: _datos.fecha,
      coordenadasN: _controllers['coordenadasN']!.text,
      coordenadasO: _controllers['coordenadasO']!.text,
      nombreInmueble: _controllers['nombreInmueble']!.text,
      calleYNumero: _controllers['calleYNumero']!.text,
      colonia: _controllers['colonia']!.text,
      codigoPostal: _controllers['codigoPostal']!.text,
      puebloCiudad: _controllers['puebloCiudad']!.text,
      municipioAlcaldia: _controllers['municipioAlcaldia']!.text,
      estado: _controllers['estado']!.text,
      referencias: _controllers['referencias']!.text,
      contacto: _controllers['contacto']!.text,
      telefono: _controllers['telefono']!.text,
      usoVivienda: _datos.usoVivienda,
      usoHospital: _datos.usoHospital,
      usoOficinas: _datos.usoOficinas,
      usoIglesia: _datos.usoIglesia,
      usoComercio: _datos.usoComercio,
      usoReunion: _datos.usoReunion,
      usoEscuela: _datos.usoEscuela,
      usoIndustrial: _datos.usoIndustrial,
      usoOtro: _datos.usoOtro,
      desocupada: _datos.desocupada,
      numeroNiveles: _datos.numeroNiveles,
      numeroSotanos: _datos.numeroSotanos,
      pisosEstacionamiento: _datos.pisosEstacionamiento,
      numeroOcupantes: _datos.numeroOcupantes,
      elevador: _datos.elevador,
      escaleraEmergencia: _datos.escaleraEmergencia,
      anioConstruccion: _datos.anioConstruccion,
      anioDanoSevero: _datos.anioDanoSevero,
      anioRehabilitacion: _datos.anioRehabilitacion,
      dimensionFrenteX: _datos.dimensionFrenteX,
      dimensionFondoY: _datos.dimensionFondoY,
      topografiaPlanicie: _datos.topografiaPlanicie,
      topografiaLadera: _datos.topografiaLadera,
      topografiaRivera: _datos.topografiaRivera,
      topografiaFondoValle: _datos.topografiaFondoValle,
      topografiaDepositosLacustres: _datos.topografiaDepositosLacustres,
      topografiaCosta: _datos.topografiaCosta,
    );
  }

  void _sincronizarSeccion1() {
    _datos.usoOtro = _controllers['usoOtro']!.text;
  }

  void _sincronizarSeccion2() {
    final n = int.tryParse(_controllers['numeroNiveles']!.text);
    final s = int.tryParse(_controllers['numeroSotanos']!.text);
    final p = int.tryParse(_controllers['pisosEstacionamiento']!.text);
    final o = int.tryParse(_controllers['numeroOcupantes']!.text);
    final c = int.tryParse(_controllers['anioConstruccion']!.text);
    final d = int.tryParse(_controllers['anioDanoSevero']!.text);
    final r = int.tryParse(_controllers['anioRehabilitacion']!.text);
    final fx = double.tryParse(_controllers['dimensionFrenteX']!.text.replaceAll(',', '.'));
    final fy = double.tryParse(_controllers['dimensionFondoY']!.text.replaceAll(',', '.'));
    _datos = _datos.copyWith(
      numeroNiveles: n,
      numeroSotanos: s,
      pisosEstacionamiento: p,
      numeroOcupantes: o,
      anioConstruccion: c,
      anioDanoSevero: d,
      anioRehabilitacion: r,
      dimensionFrenteX: fx,
      dimensionFondoY: fy,
    );
  }

  bool _puedeSiguiente() {
    switch (_pasoActual) {
      case 0:
        _sincronizarDatosBasicos();
        return _datos.tieneAlgunDatoBasico;
      case 1:
        _sincronizarSeccion1();
        return _datos.tieneAlgunUso;
      case 2:
        _sincronizarSeccion2();
        return _datos.tieneAlgunDatoSeccion2;
      case 3:
        return _datos.tieneAlgunaTopografia;
      default:
        return false;
    }
  }

  Future<void> _avanzar() async {
    if (!_puedeSiguiente()) return;
    if (_pasoActual < _totalPasos - 1) {
      setState(() => _pasoActual++);
    } else {
      _sincronizarDatosBasicos();
      _sincronizarSeccion1();
      _sincronizarSeccion2();
      setState(() => _guardando = true);
      try {
        await FirebaseService().guardarEvaluacion(_datos);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Guardado en Firebase correctamente')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: $e')),
        );
      } finally {
        if (mounted) setState(() => _guardando = false);
      }
    }
  }

  void _retroceder() {
    if (_pasoActual > 0) setState(() => _pasoActual--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación estructural'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Bloque 1: Información general',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  'Paso ${_pasoActual + 1} de $_totalPasos',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildContenidoPaso(),
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_pasoActual > 0)
                    TextButton(
                      onPressed: _retroceder,
                      child: const Text('Anterior'),
                    ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: (!_guardando && _puedeSiguiente()) ? _avanzar : null,
                    icon: _guardando
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.arrow_forward, size: 18),
                    label: Text(_pasoActual == _totalPasos - 1 ? 'Finalizar' : 'Siguiente'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContenidoPaso() {
    switch (_pasoActual) {
      case 0:
        return _buildDatosBasicos();
      case 1:
        return _buildSeccion1Uso();
      case 2:
        return _buildSeccion2();
      case 3:
        return _buildSeccion3Topografia();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDatosBasicos() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _datos.fecha ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (d != null) setState(() => _datos = _datos.copyWith(fecha: d));
                },
                icon: const Icon(Icons.calendar_today, size: 18),
                label: Text(_datos.fecha != null ? _fechaStr(_datos.fecha!) : 'Fecha'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coordenadas',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: _campoNumerico('N', _controllers['coordenadasN']!),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _campoNumerico('O', _controllers['coordenadasO']!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _campo('Nombre del Inmueble', _controllers['nombreInmueble']!),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _campo('Calle y número', _controllers['calleYNumero']!),
              ),
              const SizedBox(width: 12),
              Expanded(child: _campo('Colonia', _controllers['colonia']!)),
              const SizedBox(width: 12),
              Expanded(child: _campo('C.P.', _controllers['codigoPostal']!, teclado: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _campo('Pueblo/Ciudad', _controllers['puebloCiudad']!)),
              const SizedBox(width: 12),
              Expanded(child: _campo('Municipio/Alcaldía', _controllers['municipioAlcaldia']!)),
              const SizedBox(width: 12),
              Expanded(child: _campo('Estado', _controllers['estado']!)),
            ],
          ),
          const SizedBox(height: 12),
          _campo('Referencias (entre calles, sitio notable, etc.)', _controllers['referencias']!, lineas: 2),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _campo('Contacto (nombre, cargo, correo-e, etc.)', _controllers['contacto']!),
              ),
              const SizedBox(width: 12),
              Expanded(child: _campo('Teléfono', _controllers['telefono']!, teclado: TextInputType.phone)),
            ],
          ),
        ],
      ),
    );
  }

  String _fechaStr(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Widget _campo(String label, TextEditingController c, {int lineas = 1, String? hint, TextInputType? teclado}) {
    return TextFormField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      maxLines: lineas,
      keyboardType: teclado,
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _campoNumerico(String label, TextEditingController c) {
    return TextFormField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
      ],
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _buildSeccion1Uso() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Uso', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _chk('Vivienda', _datos.usoVivienda, (v) => setState(() => _datos.usoVivienda = v)),
            _chk('Hospital', _datos.usoHospital, (v) => setState(() => _datos.usoHospital = v)),
            _chk('Oficinas', _datos.usoOficinas, (v) => setState(() => _datos.usoOficinas = v)),
            _chk('Iglesia', _datos.usoIglesia, (v) => setState(() => _datos.usoIglesia = v)),
            _chk('Comercio', _datos.usoComercio, (v) => setState(() => _datos.usoComercio = v)),
            _chk('Reunión (Cine/estadio/salón)', _datos.usoReunion, (v) => setState(() => _datos.usoReunion = v)),
            _chk('Escuela', _datos.usoEscuela, (v) => setState(() => _datos.usoEscuela = v)),
            _chk('Industrial (fábrica/bodega)', _datos.usoIndustrial, (v) => setState(() => _datos.usoIndustrial = v)),
            _chk('Desocupada', _datos.desocupada, (v) => setState(() => _datos.desocupada = v)),
          ],
        ),
        const SizedBox(height: 12),
        _campo('Otro (especificar)', _controllers['usoOtro']!),
      ],
    );
  }

  Widget _chk(String label, bool value, ValueChanged<bool> onChanged) {
    return FilterChip(
      label: Text(label),
      selected: value,
      onSelected: (v) => onChanged(v == true),
    );
  }

  Widget _buildSeccion2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Niveles y ocupaci\u00f3n', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _campoNum('N\u00famero total de niveles, n', _controllers['numeroNiveles']!)),
            const SizedBox(width: 12),
            Expanded(child: _campoNum('N\u00famero de s\u00f3tanos', _controllers['numeroSotanos']!)),
            const SizedBox(width: 12),
            Expanded(child: _campoNum('Pisos estacionamiento', _controllers['pisosEstacionamiento']!)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _campoNum('N\u00famero de ocupantes', _controllers['numeroOcupantes']!)),
            const SizedBox(width: 12),
            _chk('Elevador', _datos.elevador, (v) => setState(() => _datos.elevador = v)),
            const SizedBox(width: 12),
            _chk('Escalera de emergencia', _datos.escaleraEmergencia, (v) => setState(() => _datos.escaleraEmergencia = v)),
          ],
        ),
        const SizedBox(height: 20),
        Text('A\u00f1o de:', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _campoNum('Construcci\u00f3n', _controllers['anioConstruccion']!)),
            const SizedBox(width: 12),
            Expanded(child: _campoNum('Da\u00f1o severo', _controllers['anioDanoSevero']!)),
            const SizedBox(width: 12),
            Expanded(child: _campoNum('Rehabilitaci\u00f3n', _controllers['anioRehabilitacion']!)),
          ],
        ),
        const SizedBox(height: 12),
        Text('Dimensiones', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _campoNum('Frente X (m)', _controllers['dimensionFrenteX']!)),
            const SizedBox(width: 12),
            Expanded(child: _campoNum('Fondo Y (m)', _controllers['dimensionFondoY']!)),
          ],
        ),
      ],
    );
  }

  Widget _campoNum(String label, TextEditingController c) {
    return TextFormField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      keyboardType: TextInputType.number,
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _buildSeccion3Topografia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Topografía', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _chk('Planicie', _datos.topografiaPlanicie, (v) => setState(() => _datos.topografiaPlanicie = v)),
            _chk('Ladera (inclinado)', _datos.topografiaLadera, (v) => setState(() => _datos.topografiaLadera = v)),
            _chk('Rivera de río/lago', _datos.topografiaRivera, (v) => setState(() => _datos.topografiaRivera = v)),
            _chk('Fondo de valle', _datos.topografiaFondoValle, (v) => setState(() => _datos.topografiaFondoValle = v)),
            _chk('Depósitos lacustres', _datos.topografiaDepositosLacustres, (v) => setState(() => _datos.topografiaDepositosLacustres = v)),
            _chk('Costa', _datos.topografiaCosta, (v) => setState(() => _datos.topografiaCosta = v)),
          ],
        ),
      ],
    );
  }
}
