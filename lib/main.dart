import 'package:flutter/material.dart';
import 'screens/viajar_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Tu Cuervo Móvil',
      home: ViajarScreen(),
    );
  }
} 