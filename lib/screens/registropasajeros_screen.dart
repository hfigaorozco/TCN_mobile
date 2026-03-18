import 'package:flutter/material.dart';
import 'shared_appbar.dart'; 

class RegistrarPasajero extends StatefulWidget {
  final int totalPasajeros;
  final int pasajeroActual;
  final int asiento;

  const RegistrarPasajero({
    super.key,
    required this.totalPasajeros,
    required this.pasajeroActual,
    required this.asiento,
  });

  @override
  State<RegistrarPasajero> createState() => _RegistrarPasajeroState();
}

class _RegistrarPasajeroState extends State<RegistrarPasajero> {
  final nombre = TextEditingController();
  final apellido1 = TextEditingController();
  final apellido2 = TextEditingController();
  final edad = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),

      // 🔥 AQUI USAS EL MISMO APPBAR
      appBar: const SharedAppBar(),

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            _cardRegistro(),

            const Spacer(),

            _botonRegresar(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _cardRegistro() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              "Registrar Pasajero",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Ingresa los datos correspondientes",
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 25),

            _input("Nombre", nombre),
            const SizedBox(height: 15),

            _input("Primer apellido", apellido1),
            const SizedBox(height: 15),

            _input("Segundo apellido", apellido2),
            const SizedBox(height: 15),

            _input("Edad del pasajero", edad),

            const SizedBox(height: 25),

            _botonContinuar(),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF4F6FB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFD0D6E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFD0D6E0)),
        ),
      ),
    );
  }

  Widget _botonContinuar() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E63B6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          print(nombre.text);
          print(apellido1.text);
          print(apellido2.text);
          print(edad.text);
          print("Asiento: ${widget.asiento}");

          if (widget.pasajeroActual < widget.totalPasajeros) {
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Pasajeros registrados correctamente"),
              ),
            );

            Navigator.pop(context);
          }
        },
        child: const Text(
          "Continuar",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _botonRegresar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.home, color: Colors.white),
          label: const Text(
            "Regresar",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E63B6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}