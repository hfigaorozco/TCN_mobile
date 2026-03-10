import 'package:flutter/material.dart';
import 'asientosplat_screen.dart';
import 'asientosplus_screen.dart';

class CorridasScreen extends StatefulWidget {
  const CorridasScreen({Key? key}) : super(key: key);

  @override
  _CorridasScreenState createState() => _CorridasScreenState();
}

class _CorridasScreenState extends State<CorridasScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),

      body: SafeArea(
        child: Column(
          children: [

            // header del logo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: const Color(0xFFE9EEF6),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TU CUERVO MÓVIL",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A5CAA),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // tarjeta de busqueda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _cardBusqueda(),
            ),

            const SizedBox(height: 20),

            // lista de corridas
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [

                  _cardCorrida(true),
                  const SizedBox(height: 15),

                  _cardCorrida(false),
                  const SizedBox(height: 15),

                  _cardCorrida(true),

                ],
              ),
            ),

            const SizedBox(height: 10),

            // boton volver
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.home, color: Colors.white),
                  label: const Text(
                    "Volver al inicio",
                    style: TextStyle(fontSize: 18,color: Colors.white),
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

  // tarjeta origen destino
  Widget _cardBusqueda() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        children: [

          Row(
            children: [

              const Text(
                "Origen",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Container(
                  height: 3,
                  color: const Color(0xFF2A5CAA),
                ),
              ),

              const SizedBox(width: 10),

              const Text(
                "Destino",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [

              Row(
                children: [
                  Text(
                    "Fecha ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "22/03/2026",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2A5CAA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    "Pasajeros ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "3",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2A5CAA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // tarjeta corrida
  Widget _cardCorrida(bool azul) {

    Color colorPrincipal =
        azul ? const Color(0xFF2A5CAA) : Colors.orange;

    return GestureDetector(

      onTap: () {

        if (azul) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AsientosPlatPlus(),
            ),
          );

        } else {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AsientosPlusPlus(),
            ),
          );

        }

      },

      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Fecha",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrincipal,
                        fontWeight: FontWeight.w600)),

                const SizedBox(height: 6),

                const Text("Origen",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 6),

                Text("Hora",
                    style: TextStyle(
                        fontSize: 18,
                        color: colorPrincipal,
                        fontWeight: FontWeight.bold)),
              ],
            ),

            Column(
              children: [

                Text("Servicio",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrincipal,
                        fontWeight: FontWeight.w600)),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 80,
                  height: 3,
                  color: colorPrincipal,
                ),

                const Text("Autobús",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),

                Text("183",
                    style: TextStyle(
                        fontSize: 18,
                        color: colorPrincipal,
                        fontWeight: FontWeight.bold)),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text("Fecha",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrincipal,
                        fontWeight: FontWeight.w600)),

                const SizedBox(height: 6),

                const Text("Destino",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 6),

                Text("Hora",
                    style: TextStyle(
                        fontSize: 18,
                        color: colorPrincipal,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // decoracion reutilizable
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 12,
          offset: Offset(0, 5),
        ),
      ],
    );
  }
}