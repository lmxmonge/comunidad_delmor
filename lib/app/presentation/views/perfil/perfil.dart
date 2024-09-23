import 'package:comunidad_delmor/app/presentation/global_widgets/sin_conexion/sin_conexion.dart';
import 'package:flutter/cupertino.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // child: const Text('Perfil'),
      child: SinConexion(),
    );
  }
}
