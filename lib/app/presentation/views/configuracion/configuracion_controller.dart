import 'package:comunidad_delmor/app/data/models/contrasenia_model.dart';
import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';

class ConfiguracionController extends GetxController {
  final ApiRespository respository;

  ConfiguracionController(this.respository);

  var antigaContraseniaVisibility = false.obs;

  var passwordVisivility = false.obs;
  var repeatPasswordVisivility = false.obs;

  void changeAntiguaPasswordVisibility() {
    antigaContraseniaVisibility.value = !antigaContraseniaVisibility.value;
  }

  void changePasswordVisibility() {
    passwordVisivility.value = !passwordVisivility.value;
  }

  void changeRepeatPasswordVisibility() {
    repeatPasswordVisivility.value = !repeatPasswordVisivility.value;
  }

  void changePassword(ContraseniaModel contraseniaModel) async {
    Get.back(); // Cerrar el diálogo.

    //mostrar barra de progreso
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
    );

    late final String respuesta;
    try {
      respuesta = await respository.cambiarContrasenia(contraseniaModel);
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
    // Eliminar el token del dispositivo
    await FirebaseMessaging.instance.deleteToken();
    print('Token de FCM eliminado.');
    Get.back();
    Get.offAllNamed(Routes.splash);
  }

  RxString newPasswordError = ''.obs; // Inicializar con cadena vacía
  RxString repeatPasswordError = ''.obs;

  RxString antigaContraseniaError = ''.obs;

  void validateAndSubmit(
    TextEditingController newPasswordController,
    TextEditingController repeatPasswordController,
    TextEditingController antigaContraseniaController,
  ) {
    antigaContraseniaError.value = antigaContraseniaController.text.isEmpty
        ? "La contraseña antigua es obligatoria"
        : '';

    newPasswordError.value = newPasswordController.text.isEmpty
        ? "La nueva contraseña es obligatoria"
        : newPasswordController.text.length < 3
            ? "Debe tener al menos 3 caracteres"
            : '';

    repeatPasswordError.value = repeatPasswordController.text.isEmpty
        ? "Repetir contraseña es obligatorio"
        : repeatPasswordController.text != newPasswordController.text
            ? "Las contraseñas no coinciden"
            : '';

    if (newPasswordError.value.isEmpty && repeatPasswordError.value.isEmpty) {

      ContraseniaModel contraseniaModel = ContraseniaModel(
        contrasenia: newPasswordController.text,
        antiguaContrasenia: antigaContraseniaController.text,
      );

      repeatPasswordController.clear();
      newPasswordController.clear();


      changePassword(contraseniaModel);
      Get.back(); // Cerrar el diálogo
    }
  }
}
