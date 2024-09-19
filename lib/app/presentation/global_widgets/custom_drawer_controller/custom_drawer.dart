import 'package:comunidad_delmor/utils/tamanios.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_pages.dart';
import '../../../../utils/iconos.dart';
import 'custom_drawer_controller.dart';

class CustomDrawer extends StatelessWidget {
   CustomDrawer({super.key});

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
