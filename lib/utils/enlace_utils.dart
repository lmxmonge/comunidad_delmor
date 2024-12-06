import 'package:comunidad_delmor/app/data/api/api_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EnlaceUtils {

  static actualizarAppDialogo() {
    print('Version app: ${ApiConstant.versionApp}');

    if (!kIsWeb) {
      if (ApiConstant.versionApp < 1) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.generalDialog(
              pageBuilder: (context, animation, secondaryAnimation) {
                return AlertDialog(
                  icon: const Icon(
                    Icons.info,
                    color: Colors.green,
                    size: 48.0,
                  ),
                  title: const Text('Actualiza la app!'),
                  content: const Text(
                      'Hay una nueva versión de la app, por favor actualiza para seguir disfrutando de todas las funcionalidades.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse('https://www.mediafire.com/file/f6063g5htacljh6/prueba.apk/file'));

                        Get.back();
                      },
                      child: const Text('Aceptar'),
                    )
                  ],
                );
              });
        });
      }
    }
  }
}