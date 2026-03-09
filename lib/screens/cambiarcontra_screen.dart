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
      appBar: const SharedAppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 62, left: 13, right: 13),
            width: 366,
            height: 58,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
            ),
            child: const Text(
              'Cambiar contraseña',
              style: TextStyle(
                fontWeight: FontWeight(700),
                color: Colors.black,
                fontSize: 34,
              ),
            ),
          ),
          const SizedBox(height: 37),
          Container(margin: EdgeInsets.only(left: 13, right: 13)),
        ],
      ),
    );
  }
}
