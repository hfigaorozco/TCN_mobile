import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/corrida.dart';
import '../models/pasajero_compra.dart';
import '../config.dart';
import 'shared_appbar.dart';
import 'shared_navbar.dart';

class ResumenCompraScreen extends StatefulWidget {
  final Corrida corrida;
  final List<PasajeroCompra> pasajeros;

  const ResumenCompraScreen({
    super.key,
    required this.corrida,
    required this.pasajeros,
  });

  @override
  State<ResumenCompraScreen> createState() => _ResumenCompraScreenState();
}

class _ResumenCompraScreenState extends State<ResumenCompraScreen> {
  bool _procesando = false;

  static const double IVA_RATE = 0.16;

  // Descuentos por tipo
  final Map<String, double> _descuentos = {
    'REGU': 0.0,
    'NINO': 0.5,
    '3DAD': 0.5,
  };

  double _precioPasajero(PasajeroCompra p) {
    final desc = _descuentos[p.tipoPasajero] ?? 0.0;
    return widget.corrida.tarifaBase * (1 - desc);
  }

  double get _subtotal =>
      widget.pasajeros.fold(0.0, (sum, p) => sum + _precioPasajero(p));

  double get _iva => _subtotal * IVA_RATE;
  double get _total => _subtotal + _iva;

  Future<void> _confirmarCompra() async {
    setState(() => _procesando = true);

    try {
      final body = {
        'corrida_id': widget.corrida.numero,
        'pasajeros': widget.pasajeros.map((p) => p.toJson()).toList(),
      };

      final response = await http.post(
        Uri.parse('${Config.baseUrl}/generar-boletos/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Compra realizada con éxito')),
          );
          // Regresar al inicio limpiando el stack
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      } else {
        final error = json.decode(response.body);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error['error'] ?? 'Intenta de nuevo'}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error de conexión')),
        );
      }
    } finally {
      if (mounted) setState(() => _procesando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: const SharedAppBar(),
      bottomNavigationBar: const SharedNavbar(selectedIndex: 1),
<<<<<<< HEAD
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(
                top: 8,
                left: 13,
                right: 13,
              ), // reducido de 13 a 8
              width: 366,
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 11,
              ), // reducido de 6 a 4
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
              ),
              child: const Text(
                'Resumen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 26, // reducido de 29 a 26
                ),
              ),
            ),
          ),
=======
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
>>>>>>> cf4e63c546ccc370965198365895c28f7c423912

            // TITULO
            _card(
              child: const Text(
                'Resumen de compra',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),

            const SizedBox(height: 16),

            // DATOS DE LA CORRIDA
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _seccion("Ruta",
                    "${widget.corrida.ciudadOrigen} - ${widget.corrida.ciudadDestino}"),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(child: _seccion("Salida",
                          "${widget.corrida.fechaSalida}\n${widget.corrida.horaSalida}")),
                      Expanded(child: _seccion("Llegada",
                          "${widget.corrida.fechaLlegada}\n${widget.corrida.horaLlegada}")),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(child: _seccion("Autobús", "${widget.corrida.autobus}")),
                      Expanded(child: _seccion("Servicio", widget.corrida.tipoAutobus == 'PLAT' ? 'PLATINO' : 'PLUS')),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // PASAJEROS
            ...widget.pasajeros.asMap().entries.map((entry) {
              final i = entry.key;
              final p = entry.value;
              final precio = _precioPasajero(p);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pasajero ${i + 1} — Asiento ${p.asientoNumero}",
                          style: const TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16, color: Color(0xFF0961C6))),
                      const SizedBox(height: 8),
                      Text("${p.nombre} ${p.apellPat} ${p.apellMat}".trim()),
                      Text("Edad: ${p.edad}"),
                      Text("Tipo: ${_labelTipo(p.tipoPasajero)}"),
                      const SizedBox(height: 5),
                      Text(
                        "\$${precio.toStringAsFixed(2)} MXN",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0961C6),
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 4),

            // TOTALES
            _card(
              child: Column(
                children: [
                  _filaCosto("Subtotal", _subtotal),
                  _filaCosto("IVA (16%)", _iva),
                  const Divider(),
                  _filaCosto("Total", _total, grande: true),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BOTON CONFIRMAR
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0961C6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: _procesando ? null : _confirmarCompra,
                child: _procesando
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Confirmar compra",
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),

            const SizedBox(height: 12),

            // BOTON CANCELAR
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text("Cancelar",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF8600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: _procesando
                  ? null
                  : () => Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9EDF6), width: 2),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: child,
    );
  }

  Widget _seccion(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontSize: 13, color: Color(0xFF0961C6), fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(valor, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _filaCosto(String label, double monto, {bool grande = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
              fontSize: grande ? 18 : 15,
              fontWeight: grande ? FontWeight.bold : FontWeight.normal)),
          Text("\$${monto.toStringAsFixed(2)} MXN",
              style: TextStyle(
                  fontSize: grande ? 18 : 15,
                  fontWeight: grande ? FontWeight.bold : FontWeight.normal,
                  color: const Color(0xFF0961C6))),
        ],
      ),
    );
  }

  String _labelTipo(String codigo) {
    const labels = {'REGU': 'Regular', 'NINO': 'Niño (50% desc)', '3DAD': '3ra Edad (50% desc)'};
    return labels[codigo] ?? codigo;
  }
}