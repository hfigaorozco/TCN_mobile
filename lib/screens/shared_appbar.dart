import 'package:flutter/material.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        child: AppBar(
          backgroundColor: const Color(0xFF1060C3),
          elevation: 4,
          shadowColor: Colors.black38,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Image.asset(
                'assets/images/appbar.png',
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}