import 'package:flutter/material.dart';

class AsientosPlusPlus extends StatefulWidget {
  const AsientosPlusPlus({super.key});

  @override
  State<AsientosPlusPlus> createState() => _AsientosPlusPlusState();
}

class _AsientosPlusPlusState extends State<AsientosPlusPlus> {

  int? seleccionado;

  final List<int> ocupados = [6, 10, 11, 18, 19, 26, 27];

  Widget asiento(int numero){

    Color color = Colors.green;

    if(ocupados.contains(numero)){
      color = Colors.grey;
    }

    if(seleccionado == numero){
      color = const Color(0xFFFF7A00);
    }

    return GestureDetector(

      onTap: (){

        if(ocupados.contains(numero)) return;

        setState(() {
          seleccionado = numero;
        });

      },

      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,

        child: Text(
          "$numero",
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget fila(int a,int b,int c,int d){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          asiento(a),
          const SizedBox(width:10),

          asiento(b),

          const SizedBox(width:50),

          asiento(c),
          const SizedBox(width:10),

          asiento(d),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF4F6FB),

      body: SafeArea(

        child: Column(
          children: [

            const SizedBox(height:10),

            _cardViaje(),

            const SizedBox(height:15),

            _cardEstados(),

            const SizedBox(height:15),

            /// MAPA CON SCROLL
            Expanded(
              child: SingleChildScrollView(
                child: _mapaBus(),
              ),
            ),

            const SizedBox(height:10),

            _botonInicio(),

            const SizedBox(height:20),

          ],
        ),
      ),
    );
  }

  /// TARJETA VIAJE (COLOR PLUS)
  Widget _cardViaje(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),

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

            const SizedBox(height:5),

            Row(
              children: [

                const Text(
                  "Origen",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(width:10),

                Expanded(
                  child: Container(
                    height:3,
                    color: Color(0xFFFF7A00),
                  ),
                ),

                const SizedBox(width:10),

                const Text(
                  "Destino",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

              ],
            ),

            const SizedBox(height:5),

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

  /// TARJETA ESTADOS
  Widget _cardEstados(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),

      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _box(),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: const [

            Row(
              children: [
                CircleAvatar(radius:8,backgroundColor: Colors.green),
                SizedBox(width:5),
                Text("Disponible")
              ],
            ),

            Row(
              children: [
                CircleAvatar(radius:8,backgroundColor: Colors.grey),
                SizedBox(width:5),
                Text("Ocupado")
              ],
            ),

            Row(
              children: [
                CircleAvatar(radius:8,backgroundColor: Color(0xFFFF7A00)),
                SizedBox(width:5),
                Text("Seleccionado")
              ],
            ),

          ],
        ),
      ),
    );
  }

  /// MAPA AUTOBUS
  Widget _mapaBus(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),

      child: Container(
        height: 900,
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFFFF7A00),
            width:3,
          ),
        ),

        child: Stack(
          alignment: Alignment.center,

          children: [

            /// IMAGEN BUS
            Positioned.fill(
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(
                  "assets/images/mapa_plus_1.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            /// ASIENTOS
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                fila(1,2,3,4),
                fila(5,6,7,8),
                fila(9,10,11,12),
                fila(13,14,15,16),
                fila(17,18,19,20),
                fila(21,22,23,24),
                fila(25,26,27,28),
                fila(29,30,31,32),
                fila(33,34,35,36),
                fila(37,38,39,40),

              ],
            ),

          ],
        ),
      ),
    );
  }

  /// BOTON
  Widget _botonInicio(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),

      child: SizedBox(
        width: double.infinity,
        height:55,

        child: ElevatedButton.icon(

          icon: const Icon(Icons.home,color:Colors.white),

          label: const Text(
            "Volver al inicio",
            style: TextStyle(
              fontSize:18,
              color:Colors.white,
            ),
          ),

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF7A00),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),

          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  BoxDecoration _box(){

    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),

      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0,4),
        )
      ],
    );
  }

}