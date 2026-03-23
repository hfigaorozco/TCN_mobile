import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://cqnoiwypofsmrmtzlyqf.supabase.co',
    anonKey: 'sb_publishable_4jbwWLvGb1uSQc-w6sCpFQ_lQWKWuMB',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tu Cuervo Móvil',
      home: const SplashScreen(),
    );
  }
} 