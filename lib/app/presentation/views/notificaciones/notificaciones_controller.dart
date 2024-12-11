import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/notificaciones_repositoty.dart';

class NotificationsController extends GetxController {
  final NotificacionesRepository repository;

  var messageTitle = 'Sin notificaciones'.obs;

  // final RxMap<String, int> notificationCounts = RxMap<String, int>({});
  // final RxMap<String, int> notificationCounts = RxMap();
  final notificationCounts = <String, int>{}.obs;

  final count = 0.obs;

  NotificationsController(this.repository);

  @override
  Future<void> onInit() async {
    super.onInit();

    await repository.initialize().then((value) async {
      repository.listenToMessages(
        onMessage: (RemoteMessage message) {
          messageTitle.value = message.notification?.title ?? "Sin título";
          print(
              "Notificación recibida  primer plano: ${message.notification?.title}");
          print("tipo: ${message.data['type']}");

          final type = message.data['type'] ?? 'general';

          notificationCounts[type] = (notificationCounts.value[type] ?? 0) + 1;
          print("Notificaciones: ${notificationCounts[type]} ");
        },
        onMessageBackground: (RemoteMessage message) {
          print("Notificación recibida en segundo plano: ${message.notification?.title}");
        },

// onMessageOpenedApp: (RemoteMessage message) {
//   print("Notificación abierta: ${message.notification?.title}");
// },
      );

      repository.enviarToken();

      final SharedPreferences prefs = await SharedPreferences.getInstance();



      count.value = prefs.getInt(Constantes.memoramdums) ?? 0;


    });

    // Escuchar notificaciones en primer plano

    // Resetea el contador de un tipo específico
    void clearBadge(String type) {
      notificationCounts[type] = 0;
    }
  }
}
