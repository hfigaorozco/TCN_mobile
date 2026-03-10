import 'package:flutter/material.dart';
import 'shared_appbar.dart';
import 'shared_navbar.dart';

class CambiarContraScreen extends StatefulWidget {
  const CambiarContraScreen({super.key});

  @override
  State<CambiarContraScreen> createState() => _CambiarContraScreenState();
}

class _CambiarContraScreenState extends State<CambiarContraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: const SharedAppBar(),
      bottomNavigationBar: const SharedNavBar(selectedIndex: 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 62, left: 13, right: 13),
                width: 366,
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 11),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
                ),
                child: const Text(
                  'Cambiar contraseña',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 37),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 366,
                padding: EdgeInsets.only(
                  top: 22,
                  bottom: 22,
                  left: 11,
                  right: 11,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFF1565C0),
                        child: Icon(
                          Icons.person,
                          size: 52,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),
                    const Text(
                      'Héctor Figueroa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nueva contraseña:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nueva contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xFFE9EDF6),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.key_outlined),
                      ),
                    ),
                    const SizedBox(height: 21),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Confirmar contraseña:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Confirmar contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xFFE9EDF6),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.key_outlined),
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0961C6),
                        minimumSize: const Size(double.infinity, 54),
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xFFCFCFCF),
                        ),
                      ),
                      child: const Text(
                        'Cambiar contraseña',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
