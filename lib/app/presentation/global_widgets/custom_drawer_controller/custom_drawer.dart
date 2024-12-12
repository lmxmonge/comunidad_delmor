import 'package:comunidad_delmor/app/presentation/views/quejas_sugerencias/quejas_sugerencias.dart';
import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:comunidad_delmor/utils/tamanios.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/iconos.dart';
import '../../routes/app_pages.dart';
import '../../views/notificaciones/notificaciones_controller.dart';
import '../list_drawer_item/dart/list_drawer_item.dart';
import 'custom_drawer_controller.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final NotificationsController notificationsController =
      Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomDrawerController>(
      builder: (controller) {
        return Drawer(

          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  image: const DecorationImage(
                    image: AssetImage(Iconos.drawerHeader),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Datos de Perfil",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),

              // Obx((){
              //   return ListTile(
              //     title: Text("count: ${notificationsController.count.value}"),
              //   );
              // }),
              // Obx(() {
              //   return notificationsController.notificationCounts.value['memoramdums'] == 0
              //       || notificationsController.notificationCounts.value['memoramdums'] == null
              //
              //       ? Container() :
              //   ListTile(
              //     title: Text(
              //         "Notificaciones  ${notificationsController.notificationCounts.value['memoramdums'] ?? 0}"),
              //   );
              // }),,
              ListDrawerItem(
                  iconPath: Iconos.userColor,
                  title: 'Perfil',
                  onTap: () {
                    controller.handleIndexChanged(0);
                  }),
              ListDrawerItem(
                  title: "Cumpleañeros",
                  iconPath: Iconos.cakeColor,
                  onTap: () {
                    controller.handleIndexChanged(1);
                  }),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Noticias",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListDrawerItem(
                hasNotification: true,
                tipoNotificacion: Constantes.circulares,
                title: "Circulares",
                iconPath: Iconos.catalogo,
                onTap: () {
                  notificationsController
                      .limpiarBadgeNotificacion(Constantes.circulares);
                  controller.handleIndexChanged(3);
                },
              ),
              ListDrawerItem(
                hasNotification: true,
                tipoNotificacion: Constantes.memoramdums,
                title: "memoramdums",
                iconPath: Iconos.memorandos,
                onTap: () {
                  notificationsController
                      .limpiarBadgeNotificacion(Constantes.memoramdums);
                  controller.handleIndexChanged(4);
                },
              ),
              ListDrawerItem(
                hasNotification: true,
                tipoNotificacion: Constantes.boletines,
                title: "Boletín Informativo",
                iconPath: Iconos.boletin,
                onTap: () {
                  notificationsController
                      .limpiarBadgeNotificacion(Constantes.boletines);
                  controller.handleIndexChanged(5);
                },
              ),
              const Divider(),
              ListDrawerItem(
                  title: "Saldo Comisariato",
                  iconPath: Iconos.comisariato,
                  onTap: () {}),
              ListDrawerItem(
                  title: "Recorrido", iconPath: Iconos.recorrido, onTap: () {}),
              ListDrawerItem(
                  title: "Comentarios y Sugerencias",
                  iconPath: Iconos.comentarios,
                  onTap: () {
                    Get.toNamed(Routes.quejasSugerencias);
                  }),
              const Divider(),
              ListDrawerItem(
                  title: "Configuración",
                  iconPath: Iconos.configuraciones,
                  onTap: () {
                    controller.handleIndexChanged(2);
                  }),
              ListDrawerItem(
                  title: "Cerrar Sesión",
                  iconPath: Iconos.cerrarSesion,
                  onTap: () {
                    controller.cerrarSesion();
                  }),
            ],
          ),
        );
      },
    );
  }
}
