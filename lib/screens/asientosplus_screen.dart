import 'package:flutter/material.dart';
import 'registropasajeros_screen.dart';

class AsientosPlusPlus extends StatefulWidget {

  final int totalPasajeros;
  final int pasajeroActual;

  const AsientosPlusPlus({
    super.key,
    required this.totalPasajeros,
    required this.pasajeroActual,
  });

  @override
  State<AsientosPlusPlus> createState() => _AsientosPlusPlusState();
}

class _AsientosPlusPlusState extends State<AsientosPlusPlus> {

  int? seleccionado;

  List<int> ocupados = [6, 10, 11, 18, 19, 26, 27];

  Widget asiento(int numero) {

    Color color = Colors.green;

    if (ocupados.contains(numero)) {
      color = Colors.grey;
    }

    if (seleccionado == numero) {
      color = const Color(0xFFFF7A00);
    }

    return GestureDetector(

      onTap: () {

        if (ocupados.contains(numero)) return;

        setState(() {
          seleccionado = numero;
        });

      },

      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,

        child: Text(
          "$numero",
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Fila normal con 4 asientos — centrada
  Widget fila(int a, int b, int c, int d) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          asiento(a),
          const SizedBox(width: 10),

          asiento(b),

          const SizedBox(width: 90),

          asiento(c),
          const SizedBox(width: 10),

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
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: paddingIzquierdo,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              asiento(a),

              const SizedBox(width: 10),

              asiento(b),

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

        child: Column(
          children: [

            const SizedBox(height: 10),

            _cardViaje(),

            const SizedBox(height: 15),

            _cardEstados(),

            const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                child: _mapaBus(),
              ),
            ),

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

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Fecha"),
                Text("Servicio PLUS"),
                Text("Fecha"),
              ],
            ),

            const SizedBox(height: 5),

            Row(
              children: [

                const Text(
                  "Origen",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Container(
                    height: 3,
                    color: Color(0xFFFF7A00),
                  ),
                ),

                const SizedBox(width: 10),

                const Text(
                  "Destino",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

              ],
            ),

            const SizedBox(height: 5),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hora"),
                Text("Autobús 183"),
                Text("Hora"),
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

            Row(
              children: [
                CircleAvatar(radius: 8, backgroundColor: Colors.green),
                SizedBox(width: 5),
                Text("Disponible")
              ],
            ),

            Row(
              children: [
                CircleAvatar(radius: 8, backgroundColor: Colors.grey),
                SizedBox(width: 5),
                Text("Ocupado")
              ],
            ),

            Row(
              children: [
                CircleAvatar(radius: 8, backgroundColor: Color(0xFFFF7A00)),
                SizedBox(width: 5),
                Text("Seleccionado")
              ],
            ),

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
          border: Border.all(
            color: const Color(0xFFFF7A00),
            width: 3,
          ),
        ),

        child: Stack(
          alignment: Alignment.center,

          children: [

            Positioned.fill(
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(
                  "assets/images/mapa_plus_1.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(height: 135),

                fila(1, 2, 3, 4),
                fila(5, 6, 7, 8),
                fila(9, 10, 11, 12),
                fila(13, 14, 15, 16),
                fila(17, 18, 19, 20),
                fila(21, 22, 23, 24),
                fila(25, 26, 27, 28),
                fila(29, 30, 31, 32),
                fila(33, 34, 35, 36),
                fila(37, 38, 39, 40),
                filaDos(41, 42),
                filaDos(43, 44),

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
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFFF7A00),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: SizedBox(
              height: 55,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                onPressed: () {

                  if (seleccionado == null) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrarPasajero(
                        totalPasajeros: widget.totalPasajeros,
                        pasajeroActual: widget.pasajeroActual,
                        asiento: seleccionado!,
                      ),
                    ),
                  ).then((_) {

                    setState(() {
                      ocupados.add(seleccionado!);
                      seleccionado = null;
                    });

                  });

                },

                child: const Text(
                  "Continuar",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),

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

      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 4),
        )
      ],
    );
  }

}