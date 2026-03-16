import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'shared_appbar.dart';
import 'shared_navbar.dart';

class CambiarContraScreen extends StatefulWidget {
  const CambiarContraScreen({super.key});

  @override
  State<CambiarContraScreen> createState() => _CambiarContraScreenState();
}

class _CambiarContraScreenState extends State<CambiarContraScreen> {
  final supabase = Supabase.instance.client;
  final nuevaContraController = TextEditingController();
  final confirmarContraController = TextEditingController();

  String? _fotoPath;
  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    _cargarFotoLocal();
  }

  @override
  void dispose() {
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
    final nueva = nuevaContraController.text.trim();
    final confirmar = confirmarContraController.text.trim();

    if (nueva.isEmpty || confirmar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    if (nueva.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La contraseña debe tener al menos 6 caracteres')),
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
      await supabase.auth.updateUser(
        UserAttributes(password: nueva),
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Contraseña cambiada exitosamente!')),
        );
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } finally {
      setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final nombre = user?.userMetadata?['name'] ?? 'Usuario';

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
                margin: const EdgeInsets.only(top: 25, left: 13, right: 13),
                width: 366,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 11),
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

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.center,
              child: Container(
                width: 366,
                padding: const EdgeInsets.only(
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

                    // FOTO DE PERFIL
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1565C0),
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: _fotoPath != null
                            ? Image.file(
                                File(_fotoPath!),
                                fit: BoxFit.cover,
                              )
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
                      nombre,
                      style: const TextStyle(
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
                          fontSize: 20,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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

                    const SizedBox(height: 21),

                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Confirmar contraseña:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF0961C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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