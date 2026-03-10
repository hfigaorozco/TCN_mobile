import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Transform.scale(
            scale: 1.5,
            child: Container(
              width: 1344,
              height: double.infinity,
              margin: const EdgeInsets.only(bottom: 420),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/signinFondo.jpeg'),
                  fit: BoxFit.cover,
                  alignment: Alignment(0, 0),
                ),
              ),
            ),
          ),

          // Logo
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 215,
                height: 63,
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
                ),
                child: const Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 44,
                  width: 163,
                ),
              ),
            ),
          ),

          // Formulario
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 17,
                left: 23,
                right: 23,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Regístrate',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight(700),
                        color: Color(0xFF2A2625),
                      ),
                    ),
                    const SizedBox(height: 0),

                    // Nombres
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nombres:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight(600),
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Ingresa tus nombres',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xFFE9EDF6),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.person_outlined),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Correo
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Correo electrónico:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight(600),
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Ingresa tu correo electrónico',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xFFE9EDF6),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.mail_outline),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Contraseña
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Contraseña:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight(600),
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Ingresa una contraseña',
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
                    const SizedBox(height: 20),

                    // Botón para registrarse
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
                        'Registrarse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight(600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
