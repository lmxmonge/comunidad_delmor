import 'package:comunidad_delmor/app/data/api/api_constant.dart';
import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EnlaceUtils {

  static actualizarAppDialogo({required int codigoInternoApi, required String url}) {
    print('codigoInternoLocal: ${Constantes.codigoInternoLocal}');

    print('codigoInternoApi: $codigoInternoApi');
    if (!kIsWeb) {
      if (Constantes.codigoInternoLocal < codigoInternoApi) {
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
                        await launchUrl(Uri.parse(url));

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