import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'registro_screen.dart';
import 'perfil_screen.dart';

final supabase = Supabase.instance.client;

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (emailController.text.isEmpty || emailController.text.contains(' ')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'El correo electrónico no puede estar vacío ni contener espacios',
          ),
        ),
      );
      return;
    } else {
      try {
        await supabase.auth.signInWithPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const PerfilScreen()),
          (route) => false,
        );
      } on AuthException catch (e) {
        if (e.message.contains('Invalid login credentials')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('La contraseña o correo son incorrectos'),
            ),
          );
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container de la imagen de fondo
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

          // Cajita del logo
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 215,
              height: 63,
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 6),
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

          // Container del formulario
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 520,
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2A2625),
                      ),
                    ),
                    const SizedBox(height: 0),

                    // Input para email
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Correo electrónico:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Ingresa tu correo electrónico',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xFFE9EDF6),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.mail_outline_outlined),
                      ),
                    ),

                    // Input para contraseña
                    const SizedBox(height: 19),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Contraseña:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFFF8600),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Ingresa tu contraseña',
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
                    const SizedBox(height: 19),

                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0961C6),
                        minimumSize: const Size(double.infinity, 54),
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xFFCFCFCF),
                        ),
                      ),
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
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
                            builder: (context) => RegistroScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Crear cuenta',
                        style: TextStyle(
                          color: Color(0xFFFF8600),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
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