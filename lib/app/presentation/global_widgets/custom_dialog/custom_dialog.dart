import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void dialogo(String s, bool error, {required String titulo}) {
    Get.generalDialog(pageBuilder: (context, animation, secondaryAnimation) {
      return AlertDialog(
        icon: Icon(
          error ? Icons.error : Icons.check,
          color: error ? Colors.red : Colors.green,
          size: 48.0,
        ),
        title: Text(titulo),
        content: Text(s),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Aceptar'),
          )
        ],
      );
    });
  }

  static void dialogoSinConexionAInternet({
    required String mensaje,
    required String titulo,
  }) {
    Get.generalDialog(pageBuilder: (context, animation, secondaryAnimation) {
      return AlertDialog(
        icon: Icon(
          Icons.signal_wifi_connected_no_internet_4,
          color: Colors.red,
          size: 48.0,
        ),
        title: Text(titulo),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Aceptar'),
          )
        ],
      );
    });
  }
}
