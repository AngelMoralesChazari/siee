import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _calleNumeroController = TextEditingController();
  final _coloniaController = TextEditingController();
  final _ciudadController = TextEditingController();
  final _estadoController = TextEditingController();
  final _cpController = TextEditingController();
  final _referenciaController = TextEditingController();
  final _observacionesController = TextEditingController();
  bool _guardando = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _calleNumeroController.dispose();
    _coloniaController.dispose();
    _ciudadController.dispose();
    _estadoController.dispose();
    _cpController.dispose();
    _referenciaController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _guardando = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formulario listo (sin guardar en base de datos)')),
    );
    Navigator.of(context).pop();
    setState(() => _guardando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo formulario'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _campo('Nombre del inmueble', _nombreController, obligatorio: true),
            const SizedBox(height: 12),
            _campo('Calle y número', _calleNumeroController, obligatorio: true),
            const SizedBox(height: 12),
            _campo('Colonia', _coloniaController, obligatorio: true),
            const SizedBox(height: 12),
            _campo('Ciudad', _ciudadController, obligatorio: true),
            const SizedBox(height: 12),
            _campo('Estado', _estadoController, obligatorio: true),
            const SizedBox(height: 12),
            _campo('Código postal', _cpController, obligatorio: true, teclado: TextInputType.number),
            const SizedBox(height: 12),
            _campo('Referencia', _referenciaController, obligatorio: false, lineas: 2),
            const SizedBox(height: 12),
            _campo('Observaciones', _observacionesController, obligatorio: false, lineas: 3),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: _guardando
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(
    String label,
    TextEditingController controller, {
    bool obligatorio = false,
    TextInputType teclado = TextInputType.text,
    int lineas = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      maxLines: lineas,
      keyboardType: teclado,
      validator: obligatorio
          ? (v) {
              if (v == null || v.trim().isEmpty) return 'Requerido';
              return null;
            }
          : null,
    );
  }
}
