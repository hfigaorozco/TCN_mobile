import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu Cuervo Móvil',
      home: HomeScreen(),
    );
  }
}

// Pantalla de Home
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Tu Cuervo Móvil",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 8, 255),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 79, 175, 239),
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(24.00),
        child: Center(
          child: Column(

            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              // Logo de TCN
              Image.asset(
                'assets/images/Logo TCN azul.png',
                height: 120,
              ),

              const SizedBox(height: 40,)

              // Text de Ingresar Origen

              // Input de Origen
              
              // Text de Ingresar Destino

              // Input de Destino

              // Text de Ingresar la fecha

              // Input de Fecha

              // Text de Ingresar una Cantidad de Pasajeros

              // Input de cantidad de Pasajeros

            ]
          )
        )
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [

          // Home
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            activeIcon: const Icon(Icons.home_outlined),
            label: "Home",
          ),

          // Mis Reservaciones
          BottomNavigationBarItem(
            icon: const Icon(Icons.airplane_ticket),
            activeIcon: const Icon(Icons.airplane_ticket_outlined),
            label: "Mis reservaciones",
          ),

          // Perfil
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            activeIcon: Icon(Icons.person_2_outlined),
            label: "Perfil",
          ),

         ]
        ),
    );
  }
}