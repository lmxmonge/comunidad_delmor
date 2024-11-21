import 'package:comunidad_delmor/app/presentation/routes/app_pages.dart';
import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawerController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  handleIndexChanged(int i) {
    if (i != _selectedIndex) Get.back();

    _selectedIndex = i;
    update(["navbar"]);
  }

  cerrarSesion() async {
    //dialogo
    Get.generalDialog(pageBuilder: (context, animation, secondaryAnimation) {
      return AlertDialog(
        title: const Text("Cerrar Sesión"),
        content: const Text("¿Está seguro que desea cerrar sesión?"),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancelar")),
          TextButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.remove(Constantes.isLogged);

                Get.back();
                Get.offAllNamed(Routes.splash);
              },
              child: const Text("Aceptar"))
        ],
      );
    });
  }

}
