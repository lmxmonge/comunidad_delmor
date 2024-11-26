import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';

class ConfiguracionController extends GetxController {
  final ApiRespository respository;

  ConfiguracionController(this.respository);

  var passwordVisivility = false.obs;
  var repeatPasswordVisivility = false.obs;

  void changePasswordVisibility() {
    passwordVisivility.value = !passwordVisivility.value;
  }

  void changeRepeatPasswordVisibility() {
    repeatPasswordVisivility.value = !repeatPasswordVisivility.value;
  }

  void changePassword(String text) async {
    Get.back(); // Cerrar el diálogo.

    //mostrar barra de progreso
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
    );

    late final String respuesta;
    try {
      respuesta = await respository.cambiarContrasenia(text);
    } catch (e) {
      cerrarBarraProgreso();
      respuesta = 'Error: $e';
      dialogo(respuesta, true);
      return;
    }
    cerrarBarraProgreso();
    dialogo(respuesta, false);
  }

  void dialogo(respuesta, bool error) {
    Get.generalDialog(pageBuilder: (context, animation, secondaryAnimation) {
      return AlertDialog(
        icon: Icon(
          error ? Icons.error : Icons.check,
          color: error ? Colors.red : Colors.green,
          size: 48.0,
        ),
        title: Text(!error ? 'Cambio de contraseña' : 'Alerta'),
        content: Text(respuesta),
        actions: [
          TextButton(
            onPressed: () {
              // Get.back();
              cerrarSession();
            },
            child: const Text('Aceptar'),
          )
        ],
      );
    });
  }

  void cerrarBarraProgreso() {
    Get.back();
  }

  Future<void> cerrarSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Get.back();
    Get.offAllNamed(Routes.splash);
  }
}
