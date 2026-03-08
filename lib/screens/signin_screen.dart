import 'package:flutter/material.dart';
import 'registro_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Container de la imagen de fondo
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 420),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginFondo.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //Cajita del logo
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 215,
              height: 63,
              margin: const EdgeInsets.only(top: 50),
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
              ),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 44,
                width: 163,
              ),
            ),
          ),

          //Container del formulario
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 520,
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                border: Border.all(color: Color(0xFFE9EDF6), width: 3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Bienvenido',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight(700),
                            color: Color(0xFF2A2625),
                          ),
                        ),
                        const SizedBox(height: 0),

                        //Input para email
                        Align(
                          alignment: Alignment.topLeft,
                          child: const Text(
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
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xFFE9EDF6),
                              ),
                            ),
                            prefixIcon: Icon(Icons.mail_outline_outlined),
                          ),
                        ),

                        //Input para contrasenia
                        const SizedBox(height: 19),
                        Align(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Contraseña:',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFFFF8600),
                              fontWeight: FontWeight(600),
                            ),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Ingresa tu contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xFFE9EDF6),
                              ),
                            ),
                            prefixIcon: Icon(Icons.key_outlined),
                          ),
                        ),
                        const SizedBox(height: 19),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0961C6),
                            minimumSize: const Size(double.infinity, 54),
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFFCFCFCF),
                            ),
                          ),
                          child: Text(
                            'Ingresar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight(600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          '¿No tienes cuenta?',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogInScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Crear cuenta',
                            style: TextStyle(
                              color: Color(0xFFFF8600),
                              fontWeight: FontWeight(700),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
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
