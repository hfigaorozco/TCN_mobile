import 'package:flutter/material.dart';

class TerminalesScreen extends StatefulWidget {
  const TerminalesScreen({super.key});

  @override
  State<TerminalesScreen> createState() => _TerminalesScreenState();
}

class _TerminalesScreenState extends State<TerminalesScreen> {
  static const Color _primaryBlue = Color(0xFF1565C0);
  static const Color _backgroundGray = Color(0xFFF2F2F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundGray,
      appBar:
      PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Image.asset(
                'assets/images/appbar.png',
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Card superior
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  const Text(
                    'Localiza tu terminal',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Selecciona tu localidad actual o permítenos acceder a tu ubicación para mostrar la terminal de TCN más cercana a ti.',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey.shade600,
                      height: 1.5
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],

              ),

            ),

            const SizedBox(height: 24),

            // Label Ciudad
            const Text(
              'Ciudad:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: _primaryBlue,
              ),
            ),
            const SizedBox(height: 8),

            // Input ciudad
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ingresa tu ciudad actual',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  prefixIcon: Icon(Icons.location_on_outlined,
                      color: Colors.grey.shade400, size: 20),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Mapa placeholder
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.map_outlined,
                    size: 48,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botón Volver al inicio
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.home_outlined, size: 20),
                label: const Text(
                  'Volver al inicio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}