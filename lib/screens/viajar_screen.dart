import 'package:flutter/material.dart';

class ViajarScreen extends StatefulWidget {
  const ViajarScreen({Key? key}) : super(key: key);

  @override
  _ViajarScreenState createState() => _ViajarScreenState();
}

class _ViajarScreenState extends State<ViajarScreen> {
  String? origenSeleccionado;
  String? destinoSeleccionado;
  DateTime? fechaSeleccionada;
  int pasajeros = 1;

  int _selectedIndex = 0;

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
              // header del logini
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: const Color(0xFFE9EEF6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // aqui poner el logini
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

              // Tarjeta de origen y destinos
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _cardOrigenDestino(),
              ),

              const SizedBox(height: 20),

              // Fecha
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _cardFecha(),
              ),

              const SizedBox(height: 15),

              // Pasajeros
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _cardPasajeros(),
              ),

              const SizedBox(height: 30),

              // Boton continuar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},//aqui va el path para la pantalla de corridas
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
                    onPressed: () {},//Para poner el path para la pantalla de terminales
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Localizar terminal",
                      style:
                          TextStyle(fontSize: 18, color: Colors.orange),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // navbar inferior
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.directions_bus, "Viajar", 0),
            _navItem(Icons.work_outline, "Mis reservaciones", 1),
            _navItem(Icons.person_outline, "Perfil", 2),
          ],
        ),
      ),
    );
  }

  // La tarjetade origen y destino
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
            value: origenSeleccionado,
            decoration: _inputDecoration(),
            hint: const Text("Selecciona origen"),
            items: ciudades.map((ciudad) {
              return DropdownMenuItem(
                  value: ciudad, child: Text(ciudad));
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
            value: destinoSeleccionado,
            decoration: _inputDecoration(),
            hint: const Text("Selecciona destino"),
            items: ciudades.map((ciudad) {
              return DropdownMenuItem(
                  value: ciudad, child: Text(ciudad));
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

  // tarjeta de las fechas
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

  // tarjeta para los pasajeros
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

              // Guarda el número que escribe el usuario,
              // lo convierte a entero y actualiza la pantalla
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

  // item de navegacion
  Widget _navItem(IconData icon, String label, int index) {
    // Indica si este ítem está activo
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {

        if (index == 0) {
          // Ya estamos en Viajar, no hacemos nada
          return;
        }

        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  ReservacionesScreen(),
            ),
          );
        }

        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  PerfilScreen(),
            ),
          );
        }

      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF1F5FBF)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color:
                  isSelected ? Colors.white : const Color(0xFF1F5FBF),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1F5FBF),
            ),
          ),
        ],
      ),
    );
  }

  // Las decoraciones
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 5)),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Color(0xFFF4F6FB),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius:
            BorderRadius.all(Radius.circular(12)),
      ),
      contentPadding:
          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

}

class PerfilScreen extends StatefulWidget {
  PerfilScreen({Key? key}) : super(key: key);

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: const Center(
        child: Text("Pantalla Perfil"),
      ),
    );
  }
}

class ReservacionesScreen extends StatefulWidget {
  ReservacionesScreen({Key? key}) : super(key: key);

  @override
  _ReservacionesScreenState createState() =>
      _ReservacionesScreenState();
}

class _ReservacionesScreenState
    extends State<ReservacionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservaciones")),
      body: const Center(
        child: Text("Pantalla Reservaciones"),
      ),
    );
  }
}