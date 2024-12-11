import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/tamanios.dart';
import '../../../views/notificaciones/notificaciones_controller.dart';

class ListDrawerItem extends StatelessWidget {
  String? tipoNotificacion;

  final String title;
  final String? iconPath;
  final VoidCallback onTap;
  bool hasNotification;

  ListDrawerItem(
      {super.key,
      required this.title,
      this.iconPath,
      required this.onTap,
      this.hasNotification = false,
      this.tipoNotificacion});

  // ${controllers.notificationCounts.value['memoramdums'] ?? 0}
  @override
  Widget build(BuildContext context) {
    final NotificationsController controllers =
        Get.find<NotificationsController>();

    return ListTile(
      leading: SizedBox(
        width: Tamanios.iconSizeDrawer + 30,
        height: Tamanios.iconSizeDrawer + 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const SizedBox(
              width: Tamanios.iconSizeDrawer + 5,
              height: Tamanios.iconSizeDrawer + 30,
            ),
            Positioned(
              left: 0,
              child: Image.asset(
                iconPath!,
                width: Tamanios.iconSizeDrawer,
                height: Tamanios.iconSizeDrawer,
              ),
            ),
            Obx(() {
              final notificationCount =
                  controllers.notificationCounts[tipoNotificacion ?? ""] ?? 0;

              // Solo mostrar si hay notificaciones
              if (hasNotification && notificationCount > 0) {
                return Positioned(
                  top: 10,
                  left: 20,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "$notificationCount",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
          ],
        ),
      ),
      title: Text(title),
      onTap: onTap,
    );
  }

  getNumeroNotificaciones(NotificationsController controller,
      {required String tipoNotificacion}) {
    var counts = controller.notificationCounts;
    return counts[tipoNotificacion] ?? 0;
  }
}
