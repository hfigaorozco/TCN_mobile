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
      body: Column(
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
                  fontWeight: FontWeight(700),
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
              child: Column(children: [
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
