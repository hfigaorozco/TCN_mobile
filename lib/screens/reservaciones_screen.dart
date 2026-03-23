import 'package:flutter/material.dart';
import 'shared_appbar.dart';
import 'shared_navbar.dart';
import 'boleto_screen.dart';

// Modelos de prueba

class ReservacionModel {
  final int numero;
  final String origen;
  final String destino;
  final String fechaSalida;
  final String horaSalida;
  final String fechaLlegada;
  final String horaLlegada;
  final String clase;
  final String autobus;
  final int numeroPasajeros;
  final List<BoletoModel> boletos;

  const ReservacionModel({
    required this.numero,
    required this.origen,
    required this.destino,
    required this.fechaSalida,
    required this.horaSalida,
    required this.fechaLlegada,
    required this.horaLlegada,
    required this.clase,
    required this.autobus,
    required this.numeroPasajeros,
    required this.boletos,
  });
}

class BoletoModel {
  final int numeroBoleto;
  final String nombrePasajero;
  final String numeroAutobus;
  final String numeroAsiento;
  final double subtotal;
  final double iva;
  final double total;

  const BoletoModel({
    required this.numeroBoleto,
    required this.nombrePasajero,
    required this.numeroAutobus,
    required this.numeroAsiento,
    required this.subtotal,
    required this.iva,
    required this.total,
  });
}

// Datos de prueba
final List<ReservacionModel> reservacionesPrueba = [
  ReservacionModel(
    numero: 1,
    origen: 'Tijuana',
    destino: 'Hermosillo',
    fechaSalida: '25/03/2026',
    horaSalida: '08:00',
    fechaLlegada: '25/03/2026',
    horaLlegada: '23:00',
    clase: 'Platino',
    autobus: '510',
    numeroPasajeros: 2,
    boletos: [
      BoletoModel(
        numeroBoleto: 1001,
        nombrePasajero: 'Hector Figueroa',
        numeroAutobus: '510',
        numeroAsiento: '7',
        subtotal: 1422.41,
        iva: 227.59,
        total: 1650.0,
      ),
      BoletoModel(
        numeroBoleto: 1002,
        nombrePasajero: 'Juan Hernandez',
        numeroAutobus: '510',
        numeroAsiento: '8',
        subtotal: 1422.41,
        iva: 128.0,
        total: 1650.0,
      ),
    ],
  ),
];

// ReservacionesScreen

class ReservacionesScreen extends StatefulWidget {
  const ReservacionesScreen({super.key});

  @override
  State<ReservacionesScreen> createState() => _ReservacionesScreenState();
}

class _ReservacionesScreenState extends State<ReservacionesScreen> {
  Widget _buildReservationCard(ReservacionModel reservacion) {
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
                          style: const TextStyle(fontSize: 14, color: Colors.white70)),
                      Text(
                        reservacion.origen,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(reservacion.horaSalida,
                          style: const TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                ),
                const Icon(Icons.directions_bus, color: Colors.white, size: 50),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(reservacion.fechaLlegada,
                          style: const TextStyle(fontSize: 14, color: Colors.white70)),
                      Text(
                        reservacion.destino,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(reservacion.horaLlegada,
                          style: const TextStyle(fontSize: 14, color: Colors.white70)),
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
                Expanded(
                  child: Text('Clase', textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ),
                Expanded(
                  child: Text('Autobús', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ),
                Expanded(
                  child: Text('Pasajeros', textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(reservacion.clase, textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Expanded(
                  child: Text(reservacion.autobus, textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Expanded(
                  child: Text('${reservacion.numeroPasajeros}', textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
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

      bottomNavigationBar: const SharedNavBar(selectedIndex: 1),
      body: SingleChildScrollView(
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
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'Tus reservaciones',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ...reservacionesPrueba
                .map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildReservationCard(r),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

// ListaPasajeros

class ListaPasajeros extends StatelessWidget {
  final ReservacionModel reservacion;

  const ListaPasajeros({super.key, required this.reservacion});

  Widget _buildBoletoCard(BuildContext context, BoletoModel boleto) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFF8600),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFF8600).withOpacity(0.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
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
                child: const Icon(Icons.confirmation_number_outlined,
                    color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      boleto.nombrePasajero,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'No. de Boleto: ${boleto.numeroBoleto}',
                      style: const TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(color: Colors.white38, height: 1),
          const SizedBox(height: 14),
          _buildDetalleRow(Icons.directions_bus_outlined, 'Autobús', boleto.numeroAutobus),
          const SizedBox(height: 8),
          _buildDetalleRow(Icons.event_seat_outlined, 'Asiento', boleto.numeroAsiento),
          const SizedBox(height: 14),
          const Divider(color: Colors.white38, height: 1),
          const SizedBox(height: 14),
          _buildCostoRow('Subtotal', boleto.subtotal),
          const SizedBox(height: 4),
          _buildCostoRow('IVA (16%)', boleto.iva),
          const SizedBox(height: 6),
          _buildCostoRow('Total', boleto.total, esTotal: true),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BoletoScreen(),
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
              child: const Text(
                'Ver boleto',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
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
        Text('$label: ',
            style: const TextStyle(fontSize: 13, color: Colors.white70)),
        Text(valor,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }

  Widget _buildCostoRow(String label, double valor, {bool esTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: esTotal ? 15 : 13,
                fontWeight: esTotal ? FontWeight.bold : FontWeight.normal,
                color: esTotal ? Colors.white : Colors.white70)),
        Text(
          '\$${valor.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: esTotal ? 15 : 13,
              fontWeight: esTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.white),
        ),
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
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Lista de pasajeros',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'No. de reservación: ${reservacion.numero}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17, color: Colors.black54),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Ruta:  ${reservacion.origen} - ${reservacion.destino}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17, color: Colors.black54),
                  ),
                  

                ],
              ),
            ),
            const SizedBox(height: 20),
            ...reservacion.boletos
                .map((b) => _buildBoletoCard(context, b))
                .toList(),
          ],
        ),
      ),
    );
  }
}