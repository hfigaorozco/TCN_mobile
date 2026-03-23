// shared navbar

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'viajar_screen.dart';
import 'reservaciones_screen.dart';
import 'perfil_screen.dart';
import 'login_screen.dart';

class SharedNavBar extends StatelessWidget {
  final int selectedIndex;

  const SharedNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, Icons.directions_bus, 'Viajar', 0),
          _navItem(context, Icons.work_outline, 'Mis reservaciones', 1),
          _navItem(context, Icons.person_outline, 'Perfil', 2),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (isSelected) return;

        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const ViajarScreen()),
            (route) => false,
          );
        }
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReservacionesScreen()),
          );
        }
        if (index == 2) {
          final session = Supabase.instance.client.auth.currentSession;
          if (session != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PerfilScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LogInScreen()),
            );
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF1F5FBF) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isSelected ? Colors.white : const Color(0xFF1F5FBF)),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Color(0xFF1F5FBF))),
        ],
      ),
    );
  }
}