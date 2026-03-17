import 'package:flutter/material.dart';
import 'Corridas_screen.dart';
import 'terminales_screen.dart';
import 'shared_appbar.dart';
import 'shared_navbar.dart';

class ViajarScreen extends StatefulWidget {
  const ViajarScreen({super.key});

  @override
  State<ViajarScreen> createState() => _ViajarScreenState();
}

class _ViajarScreenState extends State<ViajarScreen> {

  final fechaController = TextEditingController();

  String? _origen;
  String? _destino;
  int _cantPasajeros = 1;

  final List<String> ciudades = [
    'Tijuana',
    'Ensenada',
    'Mexicali',
    'Hermosillo',
    'Navojoa'
  ];

  DateTime? fechaSeleccionada;

  Future<void> seleccionarFecha(BuildContext context) async {

    final DateTime hoy = DateTime.now();
    final DateTime limite = hoy.add(const Duration(days: 15));

    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: fechaSeleccionada ?? hoy,
      firstDate: hoy,
      lastDate: limite,
    );

    if (fecha != null) {
      setState(() {
        fechaSeleccionada = fecha;
        fechaController.text =
            "${fecha.day}/${fecha.month}/${fecha.year}";
      });
    }
  }

  void aumentarPasajeros() {
    if (_cantPasajeros < 10) {
      setState(() {
        _cantPasajeros++;
      });
    }
  }

  void disminuirPasajeros() {
    if (_cantPasajeros > 1) {
      setState(() {
        _cantPasajeros--;
      });
    }
  }

  @override
  void dispose() {
    fechaController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoracion(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFFF4F6FB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 237),

      appBar: SharedAppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                const Text(
                  "¡Viajemos juntos!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "¿Cuál es tu siguiente viaje?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),

                /// CARD PRINCIPAL
                Card(
                  color: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [

                        /// ORIGEN
                        DropdownButtonFormField<String>(
                          initialValue: _origen,
                          hint: const Text("Seleccionar origen"),
                          items: ciudades.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _origen = value;
                            });
                          },
                          decoration: inputDecoracion(
                            "Origen",
                            Icons.location_city,
                          ),
                        ),

                        const SizedBox(height: 22),

                        /// DESTINO
                        DropdownButtonFormField<String>(
                          initialValue: _destino,
                          hint: const Text("Seleccionar destino"),
                          items: ciudades.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _destino = value;
                            });
                          },
                          decoration: inputDecoracion(
                            "Destino",
                            Icons.location_on,
                          ),
                        ),

                        const SizedBox(height: 22),

                        /// FECHA
                        TextField(
                          controller: fechaController,
                          readOnly: true,
                          onTap: () => seleccionarFecha(context),
                          decoration: inputDecoracion(
                            "Seleccionar fecha",
                            Icons.calendar_today,
                          ),
                        ),

                        const SizedBox(height: 22),

                        /// PASAJEROS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            const Text(
                              "Cantidad de pasajeros",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            Row(
                              children: [

                                IconButton(
                                  onPressed: disminuirPasajeros,
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),

                                Text(
                                  "$_cantPasajeros",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                IconButton(
                                  onPressed: aumentarPasajeros,
                                  icon: const Icon(Icons.add_circle_outline),
                                ),

                              ],
                            )

                          ],
                        ),

                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// BOTON CONTINUAR
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () {

                    if (_origen == null || _destino == null || fechaSeleccionada == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Completa todos los campos"),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CorridasScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Buscar corridas",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// BOTON TERMINALES
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2F2F7),
                    foregroundColor: Color(0xFFFF8600),
                    minimumSize: const Size(double.infinity, 55),
                    side: const BorderSide(
                      color: Color(0xFFFF8600),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TerminalesScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Localizar terminal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: SharedNavBar(selectedIndex: 0),
    );
  }
}