import 'package:flutter/material.dart';
import '../models/corrida.dart';
import '../models/corrida_asiento.dart';
import '../models/pasajero_compra.dart';
import '../services/asiento_service.dart';
import 'registropasajeros_screen.dart';

class AsientosPlusPlus extends StatefulWidget {
  final int totalPasajeros;
  final int pasajeroActual;
  final Corrida corrida;
  final List<PasajeroCompra> pasajerosAcumulados;

  const AsientosPlusPlus({
    super.key,
    required this.totalPasajeros,
    required this.pasajeroActual,
    required this.corrida,
    required this.pasajerosAcumulados,
  });

  @override
  State<AsientosPlusPlus> createState() => _AsientosPlusPlusState();
}

class _AsientosPlusPlusState extends State<AsientosPlusPlus> {
  int?    seleccionadoNum;
  String? seleccionadoClave;

  Map<int, CorridaAsiento> _asientosMap = {};
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarAsientos();
  }

  Future<void> _cargarAsientos() async {
    try {
      final lista = await AsientoService.obtenerAsientos(widget.corrida.numero);
      final Map<int, CorridaAsiento> mapa = {};
      for (final a in lista) {
        mapa[a.numero] = a;
      }
      setState(() {
        _asientosMap = mapa;
        _cargando    = false;
      });
    } catch (e) {
      setState(() => _cargando = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cargar asientos')),
        );
      }
    }
  }

  bool _estaOcupado(int numero) {
    final a = _asientosMap[numero];
    if (a == null) return false;
    return a.estado == 'OCUPADO' || a.estado == 'RESERVADO';
  }

  bool _yaSeleccionado(int numero) {
    return widget.pasajerosAcumulados.any((p) => p.asientoNumero == numero);
  }

  Widget asiento(int numero) {
    final ocupado   = _estaOcupado(numero);
    final yaElegido = _yaSeleccionado(numero);
    final esSel     = seleccionadoNum == numero;

    Color color = Colors.green;
    if (ocupado || yaElegido) color = Colors.grey;
    if (esSel) color = const Color(0xFFFF7A00);

    return GestureDetector(
      onTap: () {
        if (ocupado || yaElegido) return;
        setState(() {
          seleccionadoNum   = numero;
          seleccionadoClave = _asientosMap[numero]?.asiento;
        });
      },
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text("$numero",
            style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget fila(int a, int b, int c, int d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          asiento(a), const SizedBox(width: 8),
          asiento(b),
          const SizedBox(width: 90),
          asiento(c), const SizedBox(width: 8),
          asiento(d),
        ],
      ),
    );
  }

  Widget filaDos(int a, int b) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double anchoFilaNormal = 270;
        final double paddingIzquierdo =
            ((constraints.maxWidth - anchoFilaNormal) / 2).clamp(0.0, double.infinity);
        return Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: paddingIzquierdo),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              asiento(a), const SizedBox(width: 8), asiento(b),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: _cargando
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF7A00)))
          : Column(
              children: [
                const SizedBox(height: 10),
                _cardViaje(),
                const SizedBox(height: 15),
                _cardEstados(),
                const SizedBox(height: 15),
                Expanded(child: SingleChildScrollView(child: _mapaBus())),
                const SizedBox(height: 10),
                _botones(),
                const SizedBox(height: 20),
              ],
            ),
      ),
    );
  }

  Widget _cardViaje() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _box(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.corrida.fechaSalida,
                    style: const TextStyle(fontSize: 12, color: Color(0xFFFF7A00), fontWeight: FontWeight.w600)),
                const Text("PLUS",
                    style: TextStyle(fontSize: 16, color: Color(0xFFFF7A00), fontWeight: FontWeight.w600)),
                Text(widget.corrida.fechaLlegada,
                    style: const TextStyle(fontSize: 12, color: Color(0xFFFF7A00), fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(widget.corrida.ciudadOrigen,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(width: 10),
                Expanded(child: Container(height: 3, color: const Color(0xFFFF7A00))),
                const SizedBox(width: 10),
                Text(widget.corrida.ciudadDestino,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.corrida.horaSalida,
                    style: const TextStyle(fontSize: 13, color: Color(0xFFFF7A00), fontWeight: FontWeight.w600)),
                Text("Autobús: ${widget.corrida.autobus}",
                    style: const TextStyle(fontSize: 13, color: Color(0xFFFF7A00), fontWeight: FontWeight.bold)),
                Text(widget.corrida.horaLlegada,
                    style: const TextStyle(fontSize: 13, color: Color(0xFFFF7A00), fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardEstados() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _box(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Row(children: [CircleAvatar(radius: 8, backgroundColor: Colors.green), SizedBox(width: 5), Text("Disponible")]),
            Row(children: [CircleAvatar(radius: 8, backgroundColor: Colors.grey), SizedBox(width: 5), Text("Ocupado")]),
            Row(children: [CircleAvatar(radius: 8, backgroundColor: Color(0xFFFF7A00)), SizedBox(width: 5), Text("Seleccionado")]),
          ],
        ),
      ),
    );
  }

  Widget _mapaBus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 900,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFFF7A00), width: 3),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset("assets/images/mapa_plus_1.png", fit: BoxFit.contain),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 127),
                fila(1,2,3,4), fila(5,6,7,8), fila(9,10,11,12),
                fila(13,14,15,16), fila(17,18,19,20), fila(21,22,23,24),
                fila(25,26,27,28), fila(29,30,31,32), fila(33,34,35,36),
                fila(37,38,39,40), filaDos(41,42), filaDos(43,44),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _botones() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 65, height: 65,
            decoration: BoxDecoration(color: const Color(0xFFFF7A00), borderRadius: BorderRadius.circular(25)),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.home, color: Colors.white, size: 26),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A00),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: () {
                  if (seleccionadoNum == null || seleccionadoClave == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Selecciona un asiento')),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegistrarPasajero(
                        totalPasajeros:      widget.totalPasajeros,
                        pasajeroActual:      widget.pasajeroActual,
                        asientoClave:        seleccionadoClave!,
                        asientoNumero:       seleccionadoNum!,
                        corrida:             widget.corrida,
                        pasajerosAcumulados: widget.pasajerosAcumulados,
                      ),
                    ),
                  ).then((_) {
                    setState(() {
                      seleccionadoNum   = null;
                      seleccionadoClave = null;
                    });
                  });
                },
                child: const Text("Continuar", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _box() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
    );
  }
}