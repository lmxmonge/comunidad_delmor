import 'package:flutter/material.dart';

import '../../../../utils/colores.dart';
import '../../../../utils/iconos.dart';

class SinConexion extends StatelessWidget {
  const SinConexion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Iconos.sinConexion, width: 150, height: 150),
          const Text('Sin conexión...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
