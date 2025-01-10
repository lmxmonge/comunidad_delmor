import 'dart:math';

import 'package:flutter/widgets.dart';

class MediaQueryCustom {
  static var alto = 0.0;
  static var ancho = 0.0;
  static double diagonal = 0.0;

  static bool isMediumScreen = false;


  static void initMediaQueryCustom(BuildContext context) {
    alto = MediaQuery.of(context).size.height;
    ancho = MediaQuery.of(context).size.width;
    diagonal = calculateScreenDiagonal(context);
    isMediumScreen =   MediaQuery.of(context).size.width < 445;
  }

  static double calculateScreenDiagonal(BuildContext context) {
    // Obtener las dimensiones de la pantalla
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Calcular la diagonal usando la fórmula
    return sqrt(pow(width, 2) + pow(height, 2));
  }
}
