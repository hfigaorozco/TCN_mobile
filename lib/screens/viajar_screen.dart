import 'package:flutter/material.dart';
import 'reservaciones_screen.dart';
import 'perfil_screen.dart';
import 'terminales_screen.dart';
import 'shared_navbar.dart';

class ViajarScreen extends StatefulWidget {
  const ViajarScreen({super.key});

  @override
  _ViajarScreenState createState() => _ViajarScreenState();
}

class _ViajarScreenState extends State<ViajarScreen> {
  String? origenSeleccionado;
  String? destinoSeleccionado;
  DateTime? fechaSeleccionada;
  int pasajeros = 1;

  final List<String> ciudades = [
    "Tijuana",
    "Tecate",
    "Mexicali",
    "Rosarito",
    "San Quintin",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: const Color(0xFFE9EEF6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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

              const SizedBox(height: 30),

              const Text(
                "¡Viajemos juntos!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "¿Cual es tu siguiente viaje?",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _cardOrigenDestino(),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _cardFecha(),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _cardPasajeros(),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F5FBF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Continuar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TerminalesScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Localizar terminal",
                      style: TextStyle(fontSize: 18, color: Colors.orange),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const SharedNavBar(selectedIndex: 0),
    );
  }

  Widget _cardOrigenDestino() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Origen",
            style: TextStyle(
              color: Color(0xFF2A5CAA),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: _inputDecoration(),
            hint: const Text("Selecciona origen"),
            items: ciudades.map((ciudad) {
              return DropdownMenuItem(value: ciudad, child: Text(ciudad));
            }).toList(),
            onChanged: (value) {
              setState(() {
                origenSeleccionado = value;
              });
            },
          ),
          const SizedBox(height: 20),
          const Text(
            "Destino",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: _inputDecoration(),
            hint: const Text("Selecciona destino"),
            items: ciudades.map((ciudad) {
              return DropdownMenuItem(value: ciudad, child: Text(ciudad));
            }).toList(),
            onChanged: (value) {
              setState(() {
                destinoSeleccionado = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _cardFecha() {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          setState(() {
            fechaSeleccionada = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.grey),
            const SizedBox(width: 10),
            Text(
              fechaSeleccionada == null
                  ? "Seleccionar fecha"
                  : "${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardPasajeros() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              initialValue: pasajeros.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Número de pasajeros",
              ),
              onChanged: (value) {
                setState(() {
                  pasajeros = int.tryParse(value) ?? 1;
                });
              },
            ),
          ),
        ],
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

  InputDecoration _inputDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Color(0xFFF4F6FB),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}