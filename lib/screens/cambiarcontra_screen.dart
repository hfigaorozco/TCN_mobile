import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared_appbar.dart';
import '../services/api_service_contra.dart';
import '../services/api_service_login_signin.dart';

class CambiarContraScreen extends StatefulWidget {
  const CambiarContraScreen({super.key});

  @override
  State<CambiarContraScreen> createState() => _CambiarContraScreenState();
}

class _CambiarContraScreenState extends State<CambiarContraScreen> {
  final contraActualController = TextEditingController();
  final nuevaContraController = TextEditingController();
  final confirmarContraController = TextEditingController();

  String? _fotoPath;
  bool _cargando = false;
  int? _user;
  String? _nombre;
  String? _correo;

  @override
  void initState() {
    super.initState();
    _cargarFotoLocal();
    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
    final apiDatos = ApiServiceLoginSignin();
    final datos = await apiDatos.obtenerDatosUsuario();

    setState(() {
      _user = datos['id'];
      _nombre = datos['nombre'];
      _correo = datos['email'];
    });
  }

  @override
  void dispose() {
    contraActualController.dispose();
    nuevaContraController.dispose();
    confirmarContraController.dispose();
    super.dispose();
  }

  Future<void> _cargarFotoLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('avatar_path');
    if (path != null && File(path).existsSync()) {
      setState(() {
        _fotoPath = path;
      });
    }
  }

  Future<void> _cambiarContrasena() async {
    final actual = contraActualController.text;
    final nueva = nuevaContraController.text;
    final confirmar = confirmarContraController.text;
    final api = ApiServiceContra();

    if (actual.isEmpty || nueva.isEmpty || confirmar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    if (nueva.length < 8 || confirmar.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La contraseña debe tener al menos 8 caracteres'),
        ),
      );
      return;
    }

    if (nueva != confirmar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    setState(() => _cargando = true);

    try {
      await api.cambiarContra(nueva, actual);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Contraseña cambiada exitosamente!')),
        );
      }
    } on Error catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: Contraseña incorrecta')));
      }
    } finally {
      setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),

      appBar: const SharedAppBar(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
                width: 366,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 11,
                ),
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
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.center,
              child: Container(
                width: 366,
                padding: const EdgeInsets.only(
                  top: 22,
                  bottom: 22,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE9EDF6), width: 3),
                ),
                child: Column(
                  children: [
                    // FOTO DE PERFIL
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1565C0),
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: _fotoPath != null
                            ? Image.file(File(_fotoPath!), fit: BoxFit.cover)
                            : const ColoredBox(
                                color: Color(0xFF1565C0),
                                child: Icon(
                                  Icons.person,
                                  size: 52,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 11),

                    // NOMBRE DESDE SUPABASE
                    Text(
                      _nombre ?? 'Usuario',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Contraseña actual:',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: contraActualController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña actual',
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

                    const SizedBox(height: 15),

                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nueva contraseña:',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: nuevaContraController,
                      obscureText: true,
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

                    const SizedBox(height: 15),

                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Confirmar contraseña:',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: confirmarContraController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirmar contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color(0xFFE9EDF6),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.key_outlined),
                      ),
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: _cargando ? null : _cambiarContrasena,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0961C6),
                        minimumSize: const Size(double.infinity, 54),
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xFFCFCFCF),
                        ),
                      ),
                      child: _cargando
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Cambiar contraseña',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
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
