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
      appBar: AppBar(title: const Text("Tu Cuervo Móvil")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(24.00),
        child: Center(
          child: Column(

            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              // Logo de TCN

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
      )
    );
  }
}