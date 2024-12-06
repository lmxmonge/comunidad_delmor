import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTransicion extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return Stack(
      children: [
        // Fondo deseado durante la transición
        Container(color: const Color(0xffF7F0FA)),
        // Animación deslizante tipo Cupertino
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Inicia desde la derecha
            end: Offset.zero,              // Termina en el centro
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: curve ?? Curves.easeInOut, // Controla la curva de la animación
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}
