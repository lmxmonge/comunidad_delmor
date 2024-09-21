import 'package:comunidad_delmor/utils/tamanios.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/iconos.dart';
import 'custom_drawer_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  // final CustomDrawerController controller = Get.put(CustomDrawerController(),tag: "navbar",);
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
              listTileItem(
                  iconPath: Iconos.userColor,
                  title: 'Perfil',
                  onTap: () {
                    controller.handleIndexChanged(0);
                  }),
              listTileItem(
                  title: "Cumpleaños",
                  iconPath: Iconos.cakeColor,
                  onTap: () {
                    controller.handleIndexChanged(1);
                  }),
              listTileItem(
                  title: "Datos Laborales",
                  iconPath: Iconos.maletinColor,
                  onTap: () {}),
              const Divider(),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Documentos",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              listTileItem(
                  title: "Circulares",
                  iconPath: Iconos.catalogo,
                  onTap: () {},
                  hasNotification: true),
              listTileItem(
                  title: "Memorandums",
                  iconPath: Iconos.memorandos,
                  onTap: () {}),

              listTileItem(
                title: "Boletín Informativo",
                iconPath: Iconos.boletin,
                onTap: () {},
                hasNotification: true,
              ),

              const Divider(),
              listTileItem(
                  title: "Saldo Comisariato",
                  iconPath: Iconos.comisariato,
                  onTap: () {
                  }),

              listTileItem(
                  title: "Recorrido",
                  iconPath: Iconos.recorrido,
                  onTap: () {

                  }),
              const Divider(),
              listTileItem(
                  title: "Configuración",
                  iconPath: Iconos.configuraciones,
                  onTap: () {
                  }),

              listTileItem(
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

ListTile listTileItem({
  required String title,
  required String? iconPath,
  required Function onTap,
  bool hasNotification = false,
}) {
  return ListTile(
    leading: Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(
          width: Tamanios.iconSizeDrawer + 5,
          height: Tamanios.iconSizeDrawer + 30,
          // decoration:
          // BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
        ),
        Positioned(
          left: 0,
          child: Image.asset(iconPath!,
              width: Tamanios.iconSizeDrawer, height: Tamanios.iconSizeDrawer),
        ),
        hasNotification
            ? Positioned(
                top: 10,
                right: 0,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: const Center(
                      child: Text(
                    "2",
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  )),
                ),
              )
            : const SizedBox(
                width: 0,
                height: 0,
              )
      ],
    ),
    title: Text(title),
    onTap: () {
      onTap();
    },
  );
}
