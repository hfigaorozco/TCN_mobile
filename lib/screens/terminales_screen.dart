import 'package:flutter/material.dart';
import 'shared_appbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Terminal {
  final String nombre;
  final String ciudad;
  final String direccion;
  final LatLng posicion;

  const Terminal({
    required this.nombre,
    required this.ciudad,
    required this.direccion,
    required this.posicion,
  });
}

const List<Terminal> _terminalesTCN = [
  Terminal(
    nombre: 'Terminal TCN Tijuana',
    ciudad: 'Tijuana',
    direccion: 'Av. de los Insurgentes 16779, Río Tijuana 3ra Etapa, 22110 Tijuana, B.C.',
    posicion: LatLng(32.5028, -116.9501),
  ),
  Terminal(
    nombre: 'Terminal TCN Tecate',
    ciudad: 'Tecate',
    direccion: 'Av. Benito Juárez 400, Tecate Centro, 21400 Tecate, B.C.',
    posicion: LatLng(32.5737, -116.6270),
  ),
  Terminal(
    nombre: 'Terminal TCN Ensenada',
    ciudad: 'Ensenada',
    direccion: 'Av. Riveroll 1015, 22800 Ensenada, B.C.',
    posicion: LatLng(31.8722, -116.6194),
  ),
  Terminal(
    nombre: 'Terminal TCN Mexicali',
    ciudad: 'Mexicali',
    direccion: 'Calz. Independencia 1244, Centro Cívico, 21000 Mexicali, B.C.',
    posicion: LatLng(32.6370, -115.4690),
  ),
  Terminal(
    nombre: 'Terminal TCN Hermosillo',
    ciudad: 'Hermosillo',
    direccion: 'Blvd. Luis Encinas J. #400, Col. Los Naranjos, 83060 Hermosillo, Son.',
    posicion: LatLng(29.1127, -110.9783),
  ),
  Terminal(
    nombre: 'Terminal TCN Ciudad Obregón',
    ciudad: 'Ciudad Obregón',
    direccion: 'Calle Campeche #910, Col. Sochiloa, 85150 Ciudad Obregón, Son.',
    posicion: LatLng(27.4863, -109.9384),
  ),
  Terminal(
    nombre: 'Terminal TCN Culiacán',
    ciudad: 'Culiacán',
    direccion: 'Blvd. Alfonso G. Calderón S/N, Desarrollo Urbano Tres Ríos, 80106 Culiacán, Sin.',
    posicion: LatLng(24.8074, -107.3944),
  ),
  Terminal(
    nombre: 'Terminal TCN Mazatlán',
    ciudad: 'Mazatlán',
    direccion: 'Calle José Ángel Espinoza Ferrusquilla S/N, Col. Palos Prietos, 82010 Mazatlán, Sin.',
    posicion: LatLng(23.2350, -106.4180),
  ),
  Terminal(
    nombre: 'Terminal TCN Guadalajara',
    ciudad: 'Guadalajara',
    direccion: 'Av. Patria, Nueva Central Camionera, 45580 San Pedro Tlaquepaque, Jal.',
    posicion: LatLng(20.6216, -103.2858),
  ),
];

class TerminalesScreen extends StatefulWidget {
  const TerminalesScreen({super.key});

  @override
  State<TerminalesScreen> createState() => _TerminalesScreenState();
}

class _TerminalesScreenState extends State<TerminalesScreen> {
  static const Color _primaryBlue = Color(0xFF1565C0);
  static const Color _backgroundGray = Color(0xFFF2F2F7);
  static const double _radioMetros = 25000;

  LatLng _currentPosition = const LatLng(23.6345, -102.5528);
  final MapController _mapController = MapController();
  final TextEditingController _ciudadController = TextEditingController();

  Terminal? _terminalCercana;
  bool _busquedaRealizada = false;

  Future<void> obtenerUbicacion() async {
    bool servicioHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHabilitado) return;

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) return;
    }
    if (permiso == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final LatLng miPosicion = LatLng(position.latitude, position.longitude);
    final Terminal? cercana = _buscarTerminalEnRadio(miPosicion);

    setState(() {
      _currentPosition = miPosicion;
      _terminalCercana = cercana;
      _busquedaRealizada = true;
      _ciudadController.text = cercana?.ciudad ?? '';
    });

    if (cercana != null) {
      _centrarMapaEnAmbos(miPosicion, cercana.posicion);
    } else {
      _mapController.move(miPosicion, 13);
    }
  }

  Terminal? _buscarTerminalEnRadio(LatLng origen) {
    Terminal? resultado;
    double menorDistancia = double.infinity;

    for (final t in _terminalesTCN) {
      final double dist = Geolocator.distanceBetween(
        origen.latitude, origen.longitude,
        t.posicion.latitude, t.posicion.longitude,
      );
      if (dist <= _radioMetros && dist < menorDistancia) {
        menorDistancia = dist;
        resultado = t;
      }
    }
    return resultado;
  }

  void _centrarMapaEnAmbos(LatLng a, LatLng b) {
    final double latMid = (a.latitude + b.latitude) / 2;
    final double lngMid = (a.longitude + b.longitude) / 2;

    final double distKm = Geolocator.distanceBetween(
          a.latitude, a.longitude, b.latitude, b.longitude) /
        1000;

    final double zoom = distKm < 1
        ? 15
        : distKm < 5
            ? 13
            : distKm < 20
                ? 11
                : 9;

    _mapController.move(LatLng(latMid, lngMid), zoom);
  }

  List<Marker> get _marcadores {
    return [
      Marker(
        point: _currentPosition,
        width: 50,
        height: 50,
        child: const Icon(Icons.person_pin_circle, size: 44, color: Colors.lightBlue),
      ),
      if (_terminalCercana != null)
        Marker(
          point: _terminalCercana!.posicion,
          width: 50,
          height: 50,
          child: const Icon(Icons.location_pin, size: 44, color: Colors.red),
        ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundGray,
      appBar: const SharedAppBar(),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Localiza tu terminal',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Selecciona tu localidad actual o permítenos acceder a tu ubicación para mostrar la terminal de TCN más cercana a ti.',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Ciudad:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: _primaryBlue,
              ),
            ),
            const SizedBox(height: 7),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _ciudadController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Tu localización actual',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  prefixIcon: Icon(Icons.location_on_outlined,
                      color: Colors.grey.shade400, size: 20),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),

            if (_busquedaRealizada && _terminalCercana == null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'No logramos localizar terminales de TCN cercanas a ti :(',
                  style: TextStyle(fontSize: 13.5, color: Colors.grey.shade600),
                ),
              ),

            if (_busquedaRealizada && _terminalCercana != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _terminalCercana!.direccion,
                  style: TextStyle(fontSize: 13.5, color: Colors.grey.shade600),
                ),
              ),

            const SizedBox(height: 16),

            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: double.infinity,
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
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentPosition,
                      initialZoom: 5,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.flutterMap.app',
                      ),
                      MarkerLayer(markers: _marcadores),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home_outlined, size: 20),
                label: const Text(
                  'Volver al inicio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: obtenerUbicacion,
                icon: const Icon(Icons.location_pin, size: 20),
                label: const Text(
                  'Localizarme',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
              ),
            ),

          ],
        ),
      ),


    );
  }
}