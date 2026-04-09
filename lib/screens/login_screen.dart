import 'package:flutter/material.dart';
import 'registro_screen.dart';
import 'perfil_screen.dart';
import '../services/api_service_login_signin.dart';
import 'viajar_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiService = ApiServiceLoginSignin();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    if (_emailController.text.isEmpty ||
        _emailController.text.contains(' ') ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese el correo electrónico y contraseña'),
        ),
      );
      return;
    } else {
      setState(() {
        _isLoading = true;
      });

      try {
        final respuesta = await _apiService.login(
          _emailController.text,
          _passwordController.text,
        );
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ViajarScreen()),
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage =
              'El correo electrónico o la contraseña son incorrectos';
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$_errorMessage')));
      } finally {
        setState(() {
          _isLoading = false;
        });
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

                    const SizedBox(height: 20),

                    // Input para email
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Correo electrónico:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: _emailController,
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
                          fontSize: 18,
                          color: Color(0xFFFF8600),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      obscureText: true,
                      controller: _passwordController,
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

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: _isLoading ? null : _login,
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

                    const SizedBox(height: 15),

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
                          fontSize: 18,
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
