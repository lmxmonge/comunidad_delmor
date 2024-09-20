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

    return
      GetBuilder<CustomDrawerController>(builder:(controller) {
        return Drawer(

          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              listTileItem(
                  iconPath: Iconos.user,
                  title: 'Perfil',
                  onTap: () {
                    controller.handleIndexChanged(0);
                  }),
              listTileItem(title: "Cumpleaños", iconPath: Iconos.cake, onTap: () {
                controller.handleIndexChanged(1);
              }),
              listTileItem(title: "Cerrar Sesión", iconPath: Iconos.cerrarSesion, onTap: (){
                controller.cerrarSesion();
              })
            ],
          ),
        );
      }, );
  }
}

ListTile listTileItem(
    {required String title,
    required String? iconPath,
    required Function onTap}) {
  return ListTile(
    leading: Image.asset(iconPath!,
        width: Tamanios.iconSizeDrawer, height: Tamanios.iconSizeDrawer),
    title: Text(title),
    onTap: () {
      onTap();
    },
  );
}
