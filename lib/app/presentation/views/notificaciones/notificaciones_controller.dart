import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/app/presentation/views/boletin_informativo/boletin_informativo_controller.dart';
import 'package:comunidad_delmor/app/presentation/views/memorandums/memorandums_controller.dart';
import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart';

import '../../../../main.dart';
import '../../../data/repositories/notificaciones_repositoty.dart';
import '../circulares/circulares_controller.dart';

class NotificationsController extends GetxController {
  final NotificacionesRepository repository;

  var messageTitle = 'Sin notificaciones'.obs;
  final notificationCounts = <String, int>{}.obs;

  final count = 0.obs;

  NotificationsController(this.repository);

  final CircularesController circularesController =
      Get.find<CircularesController>();
  final MemorandumsController memorandumsController =
      Get.find<MemorandumsController>();
  final BoletinInformativoController boletinInformativoController =
      Get.find<BoletinInformativoController>();

  @override
  Future<void> onInit() async {
    super.onInit();

    // Detectar si la app se inició mediante una notificación
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // Manejar la notificación inicial
      _handleInitialMessage(initialMessage);
    }

    iniciarBadgesEnSegundoPlano().then((value) async {
      await repository.initialize().then((value) async {
        repository.listenToMessages(
          onMessage: (RemoteMessage message) {
            messageTitle.value = message.notification?.title ?? "Sin título";
            print(
                "Notificación recibida  primer plano: ${message.notification?.title}");
            print("tipo: ${message.data['type']}");

            final type = message.data['type'] ?? 'general';

            if (notificationCounts.value[type] != null ||
                notificationCounts.value[type] != 0) {
              notificationCounts[type] =
                  (notificationCounts.value[type] ?? 0) + 1;
              print("Notificaciones: ${notificationCounts[type]} ");
            }

            switch (message.data['type']) {
              case 'memoramdums':
                memorandumsController.fetchMemorandums();
                break;
              case 'circulares':
                circularesController.fetchCirculares();
                break;
              case 'boletines':
                circularesController.fetchCirculares();
                break;
            }
          },
          onMessageOpenedApp: (RemoteMessage) {
            print('A new onMessageOpenedApp event was published!');
          },
        );

        repository.enviarToken();
      });
    });
  }

  void _handleInitialMessage(RemoteMessage message) {
    // messageTitle.value = message.notification?.title ?? "Sin título";
    // print("Notificación inicial recibida: ${message.notification?.title}");
    // print("tipo: ${message.data['type']}");
    //
    // final type = message.data['type'] ?? 'general';
    //
    // if (notificationCounts.value[type] != null ||
    //     notificationCounts.value[type] != 0) {
    //   notificationCounts[type] =
    //       (notificationCounts.value[type] ?? 0) + 1;
    //   print("Notificaciones: ${notificationCounts[type]} ");
    // }
  }

  void clearBadge(String type) {
    notificationCounts[type] = 0;
  }

  Future<void> limpiarBadgeNotificacion(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    notificationCounts[s] = 0;
    await prefs.remove(s);
  }

  Future<void> iniciarBadgesEnSegundoPlano() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final meorandums = prefs.getInt(Constantes.memoramdums) ?? 0;
    if (meorandums != 0) {
      notificationCounts[Constantes.memoramdums] = meorandums;

      abrirDrawer();
    }

    final circulares = prefs.getInt(Constantes.circulares) ?? 0;
    if (circulares != 0) {
      notificationCounts[Constantes.circulares] = circulares;

      abrirDrawer();
    }

    final boletines = prefs.getInt(Constantes.boletines) ?? 0;
    if (boletines != 0) {
      notificationCounts[Constantes.boletines] = boletines;
      abrirDrawer();
    }
  }

  void abrirDrawer() {
    // Future.delayed(const Duration(seconds: 1), () {
    if (scaffoldKey.currentState?.isDrawerOpen == false)
      scaffoldKey.currentState?.openDrawer();
    print('Abriendo el drawer d');
    // });
  }
}
