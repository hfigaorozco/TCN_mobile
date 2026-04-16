import 'package:flutter/material.dart';
import 'Corridas_screen.dart';
import 'terminales_screen.dart';
import 'shared_appbar.dart';
import 'shared_navbar.dart';
import '../models/ciudad.dart';
import '../services/ciudad_service.dart';

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

  List<Ciudad> _ciudades = [];
  bool _cargandoCiudades = true;

  DateTime? fechaSeleccionada;

  @override
  void initState() {
    super.initState();
    _cargarCiudades();
  }

  Future<void> _cargarCiudades() async {
    try {
      final ciudades = await CiudadService.obtenerCiudades();
      setState(() {
        _ciudades = ciudades;
        _cargandoCiudades = false;
      });
    } catch (e) {
      setState(() => _cargandoCiudades = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cargar ciudades')),
        );
      }
    }
  }

  Future<void> seleccionarFecha(BuildContext context) async {
    final DateTime hoy = DateTime.now();
    final DateTime limite = hoy.add(const Duration(days: 15));

    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: fechaSeleccionada ?? hoy,
      firstDate: hoy,
      lastDate: limite,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1565C0),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1565C0),
              surface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF1565C0),
              ),
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Color(0xFF1565C0), width: 1.5),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (fecha != null) {
      setState(() {
        fechaSeleccionada = fecha;
        fechaController.text = "${fecha.day}/${fecha.month}/${fecha.year}";
      });
    }
  }

  void aumentarPasajeros() {
    if (_cantPasajeros < 10) {
      setState(() => _cantPasajeros++);
    }
  }

  void disminuirPasajeros() {
    if (_cantPasajeros > 1) {
      setState(() => _cantPasajeros--);
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
      hintStyle: const TextStyle(color: Color(0xFF1565C0)),
      prefixIcon: Icon(icon, color: const Color(0xFF1565C0)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1565C0), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1565C0), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1565C0), width: 2.5),
      ),
    );
  }

  MenuStyle get _menuStyle => MenuStyle(
    backgroundColor: const WidgetStatePropertyAll(Colors.white),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    side: const WidgetStatePropertyAll(
      BorderSide(color: Color(0xFF1565C0), width: 1.5),
    ),
    minimumSize: const WidgetStatePropertyAll(Size(200, 0)),
    maximumSize: const WidgetStatePropertyAll(Size(250, 300)),
  );

  InputDecorationTheme get _dropdownTheme => InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF1565C0), width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF1565C0), width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF1565C0), width: 2.5),
    ),
  );

  List<DropdownMenuEntry<String>> get _ciudadEntries => _ciudades.map((ciudad) {
    return DropdownMenuEntry(
      value: ciudad.nombre,
      label: ciudad.nombre,
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Color(0xFF1565C0)),
        overlayColor: WidgetStatePropertyAll(
          const Color(0xFF1565C0).withOpacity(0.08),
        ),
      ),
    );
  }).toList();

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

                /// CARD TITULO
                Card(
                  color: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    child: Column(
                      children: const [
                        Text(
                          "¡Viajemos juntos!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          "¿Cuál es tu siguiente viaje?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

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
                        _cargandoCiudades
                          ? const Center(child: CircularProgressIndicator(color: Color(0xFF1565C0)))
                          : DropdownMenu<String>(
                              hintText: "Seleccionar origen",
                              leadingIcon: const Icon(Icons.location_city, color: Color(0xFF1565C0)),
                              width: double.infinity,
                              inputDecorationTheme: _dropdownTheme,
                              menuStyle: _menuStyle,
                              dropdownMenuEntries: _ciudadEntries,
                              onSelected: (value) {
                                setState(() => _origen = value);
                              },
                            ),

                        const SizedBox(height: 22),

                        /// DESTINO
                        _cargandoCiudades
                          ? const SizedBox() // ya muestra el indicador arriba, aquí no repetimos
                          : DropdownMenu<String>(
                              hintText: "Seleccionar destino",
                              leadingIcon: const Icon(Icons.location_on, color: Color(0xFF1565C0)),
                              width: double.infinity,
                              inputDecorationTheme: _dropdownTheme,
                              menuStyle: _menuStyle,
                              dropdownMenuEntries: _ciudadEntries,
                              onSelected: (value) {
                                setState(() => _destino = value);
                              },
                            ),

                        const SizedBox(height: 22),

                        /// FECHA
                        TextField(
                          controller: fechaController,
                          readOnly: true,
                          onTap: () => seleccionarFecha(context),
                          style: const TextStyle(color: Color(0xFF1565C0)),
                          decoration: inputDecoracion(
                            "Seleccionar fecha",
                            Icons.calendar_today,
                          ),
                        ),

                        const SizedBox(height: 22),

                        /// PASAJEROS
                        Row(
                          children: [

                            const Icon(Icons.people, size: 20, color: Color(0xFF1565C0)),

                            const SizedBox(width: 5),

                            const Expanded(
                              child: Text(
                                "Cantidad de pasajeros",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: disminuirPasajeros,
                              icon: const Icon(Icons.remove_circle_outline, color: Color(0xFF1565C0)),
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
                              icon: const Icon(Icons.add_circle_outline, color: Color(0xFF1565C0)),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// BOTON CONTINUAR
                ElevatedButton.icon(
                  icon: const Icon(Icons.access_time, size: 25),
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

                    if (_origen == _destino) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("El origen y destino no pueden ser iguales"),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CorridasScreen(
                          totalPasajeros: _cantPasajeros,
                          origen: _origen!,
                          destino: _destino!,
                          fecha: fechaSeleccionada!,
                        ),
                      ),
                    );
                  },
                  label: const Text(
                    "Consultar horarios",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// BOTON TERMINALES
                ElevatedButton.icon(
                  icon: const Icon(Icons.location_on, size: 25),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8600),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
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
                  label: const Text(
                    "Localizar terminal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: SharedNavbar(selectedIndex: 0),
    );
  }
}