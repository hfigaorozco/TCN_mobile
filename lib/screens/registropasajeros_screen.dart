import 'package:flutter/material.dart';
import '../models/corrida.dart';
import '../models/pasajero_compra.dart';
import 'resumencompra_screen.dart';
import 'asientosplat_screen.dart';
import 'asientosplus_screen.dart';
import 'shared_appbar.dart';

class RegistrarPasajero extends StatefulWidget {
  final int totalPasajeros;
  final int pasajeroActual;
  final String asientoClave;
  final int asientoNumero;
  final Corrida corrida;
  final List<PasajeroCompra> pasajerosAcumulados;

  const RegistrarPasajero({
    super.key,
    required this.totalPasajeros,
    required this.pasajeroActual,
    required this.asientoClave,
    required this.asientoNumero,
    required this.corrida,
    required this.pasajerosAcumulados,
  });

  @override
  State<RegistrarPasajero> createState() => _RegistrarPasajeroState();
}

class _RegistrarPasajeroState extends State<RegistrarPasajero> {
  final nombre    = TextEditingController();
  final apellido1 = TextEditingController();
  final apellido2 = TextEditingController();
  final edad      = TextEditingController();

  @override
  void dispose() {
    nombre.dispose();
    apellido1.dispose();
    apellido2.dispose();
    edad.dispose();
    super.dispose();
  }


  String _calcularTipoPasajero(int edad) {
    if (edad < 12) return 'NINO';
    if (edad >= 60) return '3DAD';
    return 'REGU';
  }

  bool _validarLongitud(String texto) {
    final t = texto.trim();
    return t.length >= 2 && t.length <= 30;
  }

  void _continuar() {
    if (nombre.text.trim().isEmpty ||
        apellido1.text.trim().isEmpty ||
        edad.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa los campos obligatorios')),
      );
      return;
    }

    if (!_validarLongitud(nombre.text) ||
        !_validarLongitud(apellido1.text) ||
        (apellido2.text.trim().isNotEmpty && !_validarLongitud(apellido2.text))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nombre y apellidos deben tener entre 2 y 30 caracteres'),
        ),
      );
      return;
    }

    final edadInt = int.tryParse(edad.text.trim());

    if (edadInt == null || edadInt < 1 || edadInt > 120) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La edad debe estar entre 1 y 120 años')),
      );
      return;
    }

    final tipoAuto = _calcularTipoPasajero(edadInt);

    final nuevoPasajero = PasajeroCompra(
      nombre:        nombre.text.trim(),
      apellPat:      apellido1.text.trim(),
      apellMat:      apellido2.text.trim(),
      edad:          edadInt,
      tipoPasajero:  tipoAuto,
      asientoClave:  widget.asientoClave,
      asientoNumero: widget.asientoNumero,
    );

    final listaActualizada = [...widget.pasajerosAcumulados, nuevoPasajero];

    if (widget.pasajeroActual < widget.totalPasajeros) {
      final tipo = widget.corrida.tipoAutobus?.trim().toUpperCase();
      final esPlatino = tipo == 'PLAT';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => esPlatino
              ? AsientosPlatPlus(
                  totalPasajeros: widget.totalPasajeros,
                  pasajeroActual: widget.pasajeroActual + 1,
                  corrida: widget.corrida,
                  pasajerosAcumulados: listaActualizada,
                )
              : AsientosPlusPlus(
                  totalPasajeros: widget.totalPasajeros,
                  pasajeroActual: widget.pasajeroActual + 1,
                  corrida: widget.corrida,
                  pasajerosAcumulados: listaActualizada,
                ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResumenCompraScreen(
            corrida: widget.corrida,
            pasajeros: listaActualizada,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: const SharedAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _cardRegistro(),
              const SizedBox(height: 20),
              _botonRegresar(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardRegistro() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Text(
              "Pasajero ${widget.pasajeroActual} de ${widget.totalPasajeros}",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 5),
            const Text("Ingresa los datos del pasajero",
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 25),

            _input("Nombre *", nombre),
            const SizedBox(height: 15),

            _input("Primer apellido *", apellido1),
            const SizedBox(height: 15),

            _input("Segundo apellido (opcional)", apellido2),
            const SizedBox(height: 15),

            _input("Edad *", edad, esNumero: true),
            const SizedBox(height: 25),

            _botonContinuar(),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller, {bool esNumero = false}) {
    return TextField(
      controller: controller,
      keyboardType: esNumero ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF4F6FB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFD0D6E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFD0D6E0)),
        ),
      ),
    );
  }

  Widget _botonContinuar() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E63B6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: _continuar,
        child: Text(
          widget.pasajeroActual < widget.totalPasajeros
              ? "Siguiente pasajero"
              : "Ver resumen",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _botonRegresar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          label: const Text("Regresar",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E63B6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}