import 'package:flutter/material.dart';
import 'shared_appbar.dart';

class BoletoScreen extends StatefulWidget {
  const BoletoScreen({super.key});

  @override
  State<BoletoScreen> createState() => _BoletoScreenState();
}

class _BoletoScreenState extends State<BoletoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: SharedAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 32),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 14),
                Image.asset(
                  'assets/images/Logo TCN azul.png',
                  height: 140,
                  width: 140,
                ),
                SizedBox(width: 42),
                Column(
                  children: [
                    Text(
                      'No. Reservación',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '001',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF0961C6),
                      ),
                    ),
                    Text(
                      'No. Boleto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '1001',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF0961C6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 18),
            Container(color: Color(0xFF0961C6), width: 300, height: 5),
            SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          'Salida',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '22/02/2026',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0961C6),
                          ),
                        ),
                        Text(
                          '12:00',
                          style: TextStyle(
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
                        Text(
                          'Llegada',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '22/02/2026',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0961C6),
                          ),
                        ),
                        Text(
                          '2:00',
                          style: TextStyle(
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
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 313,
                height: 82,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 240, 240),
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
                          Text(
                            'Origen',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Tijuana',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0961C6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Destino',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Hermosillo',
                            style: TextStyle(
                              fontSize: 14,
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
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Pasajero',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Hector Armando Figueroa',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(0xff0961C6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(color: Color(0xFF0961C6), width: 300, height: 5),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'No. Asiento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '7',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Autobús',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '510',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tipo pasajero',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Normal',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      SizedBox(height: 67),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Precio boleto',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '\$1650',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Descuento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '0%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total descuento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '\$0',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0961C6),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 173,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 245, 240, 240),
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
                                'Total: \$1650',
                                style: TextStyle(
                                  fontSize: 14,
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
