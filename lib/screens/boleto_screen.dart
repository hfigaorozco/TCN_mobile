import 'package:flutter/material.dart';
import 'shared_appbar.dart';
import '../models/reservacion_response.dart';

class BoletoScreen extends StatelessWidget {
  final BoletoResponse boleto;
  final ReservacionResponse reservacion;

  const BoletoScreen({
    super.key,
    required this.boleto,
    required this.reservacion,
  });

  // Función para mostrar HH:MM (sin segundos)
  String _formatearHora(String hora) {
    final partes = hora.split(":");
    if (partes.length >= 2) {
      return "${partes[0]}:${partes[1]}";
    }
    return hora;
  }

  @override
  Widget build(BuildContext context) {
    // Calculos de descuento
    final double porcentajeDesc = boleto.tipoPasajero == 'NINO' || boleto.tipoPasajero == '3DAD' ? 50.0 : 0.0;
    final double tarifaBase     = boleto.precio / (1 - porcentajeDesc / 100);
    final double montoDescuento = tarifaBase * (porcentajeDesc / 100);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: SharedAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 32),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 14),
                Image.asset(
                  'assets/images/Logo TCN azul.png',
                  height: 110,
                  width: 110,
                ),
                const SizedBox(width: 42),
                Column(
                  children: [
                    const Text(
                      'No. Reservación',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${reservacion.numero}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF0961C6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'No. Boleto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${boleto.numero}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF0961C6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(color: const Color(0xFF0961C6), width: 300, height: 5),
            const SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        const Text(
                          'Salida',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          reservacion.fechaSalida,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0961C6),
                          ),
                        ),
                        Text(
                          _formatearHora(reservacion.horaSalida),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0961C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        const Text(
                          'Llegada',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          reservacion.fechaLlegada,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0961C6),
                          ),
                        ),
                        Text(
                          _formatearHora(reservacion.horaLlegada),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0961C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 313,
                height: 82,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 240, 240),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF969090), width: 3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 31,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Origen',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            reservacion.ciudadOrigen,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xFF0961C6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Destino',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            reservacion.ciudadDestino,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xFF0961C6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    'Pasajero',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    boleto.nombrePasajero,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 19,
                      color: Color(0xff0961C6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(color: const Color(0xFF0961C6), width: 300, height: 5),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'No. Asiento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${boleto.asientoNumero}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Autobús',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${reservacion.autobus}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tipo pasajero',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        boleto.tipoPasajeroDesc,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      const SizedBox(height: 67),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Precio boleto',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '\$${boleto.precio.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Descuento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${porcentajeDesc.toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Total descuento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '\$${montoDescuento.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 173,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 240, 240),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF969090),
                            width: 3,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 31,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: \$${boleto.precio.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}