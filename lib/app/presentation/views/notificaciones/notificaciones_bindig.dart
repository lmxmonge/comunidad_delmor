import 'package:get/get.dart';
import '../../../data/repositories/notificaciones_repositoty.dart';
import '../../../data/services/firebase_service.dart';
import 'notificaciones_controller.dart';

class NotificacionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseService>(() => FirebaseService());
    Get.lazyPut<NotificacionesRepository>(
        () => NotificacionesRepository(Get.find(), Get.find()));

    Get.lazyPut<NotificationsController>(
        () => NotificationsController(Get.find()));
  }
}
