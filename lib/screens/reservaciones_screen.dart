import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reservacion_response.dart';
import '../services/reservacion_service.dart';
import 'shared_appbar.dart';
import 'shared_navbar.dart';
import 'boleto_screen.dart';

class ReservacionesScreen extends StatefulWidget {
  const ReservacionesScreen({super.key});

  @override
  State<ReservacionesScreen> createState() => _ReservacionesScreenState();
}

class _ReservacionesScreenState extends State<ReservacionesScreen> {
  List<ReservacionResponse> _reservaciones = [];
  bool _cargando = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _cargarReservaciones();
  }

  Future<void> _cargarReservaciones() async {
    try {
      final prefs     = await SharedPreferences.getInstance();
      final usuarioId = prefs.getInt('id');

      if (usuarioId == null) {
        setState(() { _error = 'No hay sesión activa'; _cargando = false; });
        return;
      }

      final reservaciones = await ReservacionService.obtenerReservaciones(usuarioId);
      setState(() { _reservaciones = reservaciones; _cargando = false; });
    } catch (e) {
      setState(() { _error = 'Error al cargar reservaciones'; _cargando = false; });
    }
  }

  // Función para formatear horas HH:MM
  String _formatearHora(String hora) {
    final partes = hora.split(":");
    if (partes.length >= 2) return "${partes[0]}:${partes[1]}";
    return hora;
  }

  Widget _buildReservationCard(ReservacionResponse reservacion) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListaPasajeros(reservacion: reservacion),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1565C0),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reservacion.fechaSalida,
                          style: const TextStyle(fontSize: 13, color: Colors.white70)),
                      Text(reservacion.ciudadOrigen,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(_formatearHora(reservacion.horaSalida),
                          style: const TextStyle(fontSize: 13, color: Colors.white70)),
                    ],
                  ),
                ),
                const Icon(Icons.directions_bus, color: Colors.white, size: 50),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(reservacion.fechaLlegada,
                          style: const TextStyle(fontSize: 13, color: Colors.white70)),
                      Text(reservacion.ciudadDestino,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(_formatearHora(reservacion.horaLlegada),
                          style: const TextStyle(fontSize: 13, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white, thickness: 1),
            const SizedBox(height: 8),
            const Row(
              children: [
                Expanded(child: Text('Clase', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14, color: Colors.white70))),
                Expanded(child: Text('Autobús', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white70))),
                Expanded(child: Text('Pasajeros', textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14, color: Colors.white70))),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(child: Text(
                    reservacion.estado == 'PLAT' ? 'Platino' : 'Plus',
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
                Expanded(child: Text('${reservacion.autobus}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
                Expanded(child: Text('${reservacion.cantPasajeros}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: const SharedAppBar(),
      bottomNavigationBar: const SharedNavbar(selectedIndex: 1),
      body: _cargando
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF1565C0)))
        : _error != null
          ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05),
                            blurRadius: 4, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: const Text('Tus reservaciones',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 20),
                  if (_reservaciones.isEmpty)
                    const Center(
                      child: Text('No tienes reservaciones aún',
                          style: TextStyle(fontSize: 16, color: Colors.black54)),
                    )
                  else
                    ..._reservaciones.map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildReservationCard(r),
                    )),
                ],
              ),
            ),
    );
  }
}

// ListaPasajeros

class ListaPasajeros extends StatelessWidget {
  final ReservacionResponse reservacion;

  const ListaPasajeros({super.key, required this.reservacion});

  Widget _buildBoletoCard(BuildContext context, BoletoResponse boleto, ReservacionResponse reservacion) {
    final iva      = boleto.precio * 0.16;
    final subtotal = boleto.precio - iva;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF8600),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8600).withOpacity(0.35),
            blurRadius: 8, offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.confirmation_number_outlined, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No. de Boleto: ${boleto.numero}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text(boleto.tipoPasajeroDesc,
                        style: const TextStyle(fontSize: 13, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(color: Colors.white38, height: 1),
          const SizedBox(height: 14),
          _buildDetalleRow(Icons.directions_bus_outlined, 'Autobús', '${reservacion.autobus}'),
          const SizedBox(height: 8),
          _buildDetalleRow(Icons.event_seat_outlined, 'Asiento', '${boleto.asientoNumero}'),
          const SizedBox(height: 14),
          const Divider(color: Colors.white38, height: 1),
          const SizedBox(height: 14),
          _buildCostoRow('Subtotal', subtotal),
          const SizedBox(height: 4),
          _buildCostoRow('IVA (16%)', iva),
          const SizedBox(height: 6),
          _buildCostoRow('Total', boleto.precio, esTotal: true),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BoletoScreen(
                      boleto:      boleto,
                      reservacion: reservacion,
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white),
                ),
              ),
              child: const Text('Ver boleto',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetalleRow(IconData icono, String label, String valor) {
    return Row(
      children: [
        Icon(icono, size: 18, color: Colors.white70),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontSize: 13, color: Colors.white70)),
        Text(valor, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }

  Widget _buildCostoRow(String label, double valor, {bool esTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(
            fontSize: esTotal ? 15 : 13,
            fontWeight: esTotal ? FontWeight.bold : FontWeight.normal,
            color: esTotal ? Colors.white : Colors.white70)),
        Text('\$${valor.toStringAsFixed(2)}', style: TextStyle(
            fontSize: esTotal ? 15 : 13,
            fontWeight: esTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.white)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: const SharedAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.06),
                      blurRadius: 6, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  const Text('Lista de pasajeros',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('No. de reservación: ${reservacion.numero}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 17, color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text('Ruta:  ${reservacion.ciudadOrigen} - ${reservacion.ciudadDestino}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 17, color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...reservacion.boletos
                .map((b) => _buildBoletoCard(context, b, reservacion))
                .toList(),
          ],
        ),
      ),
    );
  }
}