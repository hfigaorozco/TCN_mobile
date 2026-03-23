import 'package:flutter/material.dart';
import 'package:tcn/screens/shared_navbar.dart';
import 'shared_appbar.dart';

class ResumenCompraScreen extends StatefulWidget {
  const ResumenCompraScreen({super.key});

  @override
  State<ResumenCompraScreen> createState() => _ResumenCompraScreenState();
}

class _ResumenCompraScreenState extends State<ResumenCompraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: const SharedAppBar(),
      bottomNavigationBar: const SharedNavBar(selectedIndex: 1),
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

          const SizedBox(height: 21), // reducido de 21 a 12
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 366,
                padding: const EdgeInsets.only(
                  top: 12, // reducido de 19 a 12
                  bottom: 12, // reducido de 19 a 12
                  left: 11,
                  right: 11,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Total:',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24, // reducido de 29 a 24
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4), // reducido de 10 a 4
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        '\$3000.00 MXN',
                        style: TextStyle(
                          fontSize: 26, // reducido de 31 a 26
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12), // reducido de 25 a 12
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Ruta',
                            style: TextStyle(
                              fontSize: 17, // reducido de 19 a 17
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0961C6),
                            ),
                          ),
                        ),
                        const SizedBox(width: 140, height: 1),
                        Align(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Autobús',
                            style: TextStyle(
                              fontSize: 17, // reducido de 19 a 17
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0961C6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 185,
                            height: 54, // altura fija para textfield mas bajo
                            child: TextField(
                              readOnly: true,
                              enabled: true,
                              controller: TextEditingController(
                                text: 'SFL - SQT',
                              ),
                              style: const TextStyle(
                                fontSize: 13,
                              ), // texto mas pequeño
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ), // reduce padding interno
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: const Color(0xFFE9EDF6),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.map_outlined,
                                  size: 18,
                                ), // icono mas pequeño
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 120,
                            height: 54, // altura fija para textfield mas bajo
                            child: TextField(
                              readOnly: true,
                              enabled: true,
                              controller: TextEditingController(text: '432'),
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: const Color(0xFFE9EDF6),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.airport_shuttle,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // reducido de 10 a 8
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Salida',
                        style: TextStyle(
                          fontSize: 17, // reducido de 19 a 17
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 54, // altura fija para textfield mas bajo
                        child: TextField(
                          readOnly: true,
                          enabled: true,
                          controller: TextEditingController(
                            text: 'Jue, 12 Mar - 09:00 Hrs',
                          ),
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 3,
                                color: const Color(0xFFE9EDF6),
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.map_outlined,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8), // reducido de 10 a 8
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Llegada',
                        style: TextStyle(
                          fontSize: 17, // reducido de 19 a 17
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 54, // altura fija para textfield mas bajo
                        child: TextField(
                          readOnly: true,
                          enabled: true,
                          controller: TextEditingController(
                            text: 'Jue, 12 Mar - 12:00 Hrs',
                          ),
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 3,
                                color: const Color(0xFFE9EDF6),
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.map_outlined,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8), // reducido de 10 a 8
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Servicio',
                            style: TextStyle(
                              fontSize: 17, // reducido de 19 a 17
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0961C6),
                            ),
                          ),
                        ),
                        const SizedBox(width: 80, height: 1),
                        Align(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Asientos',
                            style: TextStyle(
                              fontSize: 17, // reducido de 19 a 17
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0961C6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 160,
                            height: 54, // altura fija para textfield mas bajo
                            child: TextField(
                              readOnly: true,
                              enabled: true,
                              controller: TextEditingController(
                                text: 'PLATINO',
                              ),
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: const Color(0xFFE9EDF6),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.map_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 100,
                            height: 54, // altura fija para textfield mas bajo
                            child: TextField(
                              readOnly: true,
                              enabled: true,
                              controller: TextEditingController(text: '10'),
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: const Color(0xFFE9EDF6),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.airport_shuttle,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // reducido de 10 a 8
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0961C6),
                        minimumSize: const Size(
                          double.infinity,
                          42,
                        ), // altura reducida de 54 a 42
                        padding: EdgeInsets.zero,
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xFFCFCFCF),
                        ),
                      ),
                      child: const Text(
                        'Volver a Inicio',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20, // reducido de 24 a 20
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
