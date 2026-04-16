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

  // Función para mostrar HH:MM (sin segundos)
  String _formatearHora(String hora) {
    final partes = hora.split(":");
    if (partes.length >= 2) {
      return "${partes[0]}:${partes[1]}";
    }
    return hora;
  }

  // Función para mostrar DD/MM de la fecha
  String _formatearFecha(String fecha) {
    try {
      final dt = DateTime.parse(fecha);
      return "${dt.day.toString().padLeft(2,'0')}/${dt.month.toString().padLeft(2,'0')}";
    } catch (e) {
      return fecha;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fechaStr =
        "${widget.fecha.day.toString().padLeft(2,'0')}/${widget.fecha.month.toString().padLeft(2,'0')}";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: const SharedAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

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
    return SizedBox(
      width: double.infinity,  
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                "Horarios",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardCorrida(Corrida corrida) {
    final tipo = corrida.tipoAutobus.trim().toUpperCase();

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
        padding: const EdgeInsets.all(10),
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
                  const SizedBox(height: 10),
                  Text(esPlatino ? "Platino" : esPlus ? "Plus" : tipo ?? "",
                    style: TextStyle(fontSize: 15,
                      color: colorPrincipal,
                      fontWeight: FontWeight.w800)
                  ),
    
                  const SizedBox(height: 8),

                  Container(
                    height: 2,
                    color: colorPrincipal,
                  ),

                  const SizedBox(height: 8),

                  Text("Autobús ${corrida.autobus}",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold, color: colorPrincipal,)),
                  const SizedBox(height: 3.5),
                  Text("\$${corrida.tarifaBase.toStringAsFixed(0)}",
                    style: TextStyle(
                        fontSize: 14,
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