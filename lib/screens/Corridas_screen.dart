import 'package:flutter/material.dart';
import 'package:tcn/screens/shared_appbar.dart';
import '../models/corrida.dart';
import '../services/corrida_service.dart';
import 'asientosplat_screen.dart';
import 'asientosplus_screen.dart';

class CorridasScreen extends StatefulWidget {
  final int totalPasajeros;
  final String origen;
  final String destino;
  final DateTime fecha;

  const CorridasScreen({
    super.key,
    required this.totalPasajeros,
    required this.origen,
    required this.destino,
    required this.fecha,
  });

  @override
  _CorridasScreenState createState() => _CorridasScreenState();
}

class _CorridasScreenState extends State<CorridasScreen> {
  List<Corrida> _corridas = [];
  bool _cargando = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _buscarCorridas();
  }

  Future<void> _buscarCorridas() async {
    try {
      final corridas = await CorridaService.buscarCorridas(
        origen: widget.origen,
        destino: widget.destino,
        fecha: widget.fecha,
        pasajeros: widget.totalPasajeros,
      );
      setState(() {
        _corridas = corridas;
        _cargando = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar corridas';
        _cargando = false;
      });
    }
  }

  String _formatearHora(String hora) {
    final partes = hora.split(":");
    if (partes.length >= 2) {
      return "${partes[0]}:${partes[1]}";
    }
    return hora;
  }

  String _formatearFecha(String fecha) {
    final partes = fecha.split("-");
    if (partes.length == 3) {
      return "${partes[1]}/${partes[2]}";
    }
    return fecha;
  }

  @override
  Widget build(BuildContext context) {
    final fechaStr = '${widget.fecha.month}/${widget.fecha.day}';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: const SharedAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _cardBusqueda(fechaStr),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: _cargando
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: Color(0xFF2A5CAA)))
                  : _error != null
                      ? Center(
                          child: Text(_error!,
                              style: const TextStyle(color: Colors.red)))
                      : _corridas.isEmpty
                          ? const Center(
                              child: Text(
                                'No hay corridas disponibles\npara los criterios seleccionados',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            )
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: _corridas.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 15),
                              itemBuilder: (_, index) =>
                                  _cardCorrida(_corridas[index]),
                            ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.home, color: Colors.white),
                  label: const Text(
                    "Volver al inicio",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F5FBF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _cardBusqueda(String fechaStr) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.origen,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 2,
                  color: const Color(0xFF2A5CAA),
                ),
              ),

              Text(widget.destino,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Text("Fecha "),
                Text(fechaStr,
                    style: const TextStyle(
                        color: Color(0xFF2A5CAA),
                        fontWeight: FontWeight.bold)),
              ]),
              Row(children: [
                const Text("Pasajeros "),
                Text("${widget.totalPasajeros}",
                    style: const TextStyle(
                        color: Color(0xFF2A5CAA),
                        fontWeight: FontWeight.bold)),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardCorrida(Corrida corrida) {
    final tipo = corrida.tipoAutobus?.trim().toUpperCase();

    final bool esPlatino = tipo == 'PLAT';
    final bool esPlus = tipo == 'PLUS';

    final Color colorPrincipal =
        esPlatino ? const Color(0xFF2A5CAA) : Colors.orange;

    return GestureDetector(
      onTap: () {
        if (esPlatino) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AsientosPlatPlus(
                totalPasajeros: widget.totalPasajeros,
                pasajeroActual: 1,
                corrida: corrida,
                pasajerosAcumulados: const [],
              ),
            ),
          );
        } else if (esPlus) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AsientosPlusPlus(
                totalPasajeros: widget.totalPasajeros,
                pasajeroActual: 1,
                corrida: corrida,
                pasajerosAcumulados: const [],
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tipo de autobús no soportado: $tipo')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // IZQUIERDA
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_formatearFecha(corrida.fechaSalida),
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrincipal,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(corrida.ciudadOrigen,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(_formatearHora(corrida.horaSalida),
                    style: TextStyle(
                        fontSize: 14,
                        color: colorPrincipal,
                        fontWeight: FontWeight.bold)),
              ],
            ),

            const SizedBox(width: 10),

            // CENTRO (EXPANDIBLE)
            Expanded(
              child: Column(
                children: [
                  Text("\$${corrida.tarifaBase.toStringAsFixed(0)}",
                      style: TextStyle(
                          fontSize: 13,
                          color: colorPrincipal,
                          fontWeight: FontWeight.w600)),

                  const SizedBox(height: 6),

                  Container(
                    height: 2,
                    color: colorPrincipal,
                  ),

                  const SizedBox(height: 6),

                  Text("Autobús ${corrida.autobus}",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  Text("${corrida.lugaresDisp} lugares",
                      style: TextStyle(
                          fontSize: 11,
                          color: colorPrincipal,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // DERECHA
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_formatearFecha(corrida.fechaLlegada),
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrincipal,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(corrida.ciudadDestino,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(_formatearHora(corrida.horaLlegada),
                    style: TextStyle(
                        fontSize: 14,
                        color: colorPrincipal,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 5)),
      ],
    );
  }
}