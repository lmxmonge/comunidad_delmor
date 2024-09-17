import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              icon: const Icon(Icons.home),
              title: 'Perfil',
              onTap: () {
                Get.toNamed(Routes.home);
              }),

          listTileItem(
              icon: const Icon(Icons.other_houses),
              title: 'Other',
              onTap: () {
                Get.toNamed(Routes.other);
              }),
        ],
      ),
    );
  }
}

ListTile listTileItem(
    {required String title, required Icon icon, required Function onTap}) {
  return ListTile(
    leading: icon,
    title: Text(title),
    onTap: () {
      onTap();
    },
  );
}
