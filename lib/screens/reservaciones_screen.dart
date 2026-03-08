import 'package:flutter/material.dart';
import 'shared_appbar.dart';
import 'shared_navbar.dart';

class ReservacionesScreen extends StatefulWidget {
  const ReservacionesScreen({super.key});

  @override
  State<ReservacionesScreen> createState() => _ReservacionesScreenState();
}

class _ReservacionesScreenState extends State<ReservacionesScreen> {

  Widget _buildReservationCard() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('fecha', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  Text(
                    'Origen',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text('hora', style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
              const Icon(Icons.directions_bus, color: Colors.white, size: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('fecha', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  Text(
                    'Destino',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text('hora', style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(color: Colors.white38, thickness: 1),
          const SizedBox(height: 8),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Clase', style: TextStyle(fontSize: 12, color: Colors.white70)),
              Text('Autobus', style: TextStyle(fontSize: 12, color: Colors.white70)),
              Text('Pasajeros', style: TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Clase', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Autobus', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Pasajero', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ],
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),
            _buildReservationCard(),
            const SizedBox(height: 20),
            _buildReservationCard(),
            const SizedBox(height: 20),
            _buildReservationCard(),
          ],
        ),
      ),
    );
  }
}