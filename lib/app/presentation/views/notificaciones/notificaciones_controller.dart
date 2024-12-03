import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../data/repositories/notificaciones_repositoty.dart';

class NotificationsController extends GetxController {
  final NotificacionesRepository repository;

  var messageTitle = 'Sin notificaciones'.obs;

  NotificationsController(this.repository);

  @override
  Future<void> onInit() async {
    super.onInit();

    await repository.initialize().then((value) {
      repository.listenToMessages(
        onMessage: (RemoteMessage message) {
          messageTitle.value = message.notification?.title ?? "Sin título";
          print("Notificación recibida: ${message.notification?.title}");
        },
        // onMessageOpenedApp: (RemoteMessage message) {
        //   print("Notificación abierta: ${message.notification?.title}");
        // },
      );

      repository.enviarToken();
    });

    // Escuchar notificaciones en primer plano
  }
}
