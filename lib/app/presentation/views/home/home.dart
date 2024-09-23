// lib/app/views/home_view.dart
import 'package:comunidad_delmor/app/presentation/global_widgets/custom_drawer_controller/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.other);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenido a Flutter con GetX'),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Obx(() => Text("este es un contador : ${controller.counter.valor}")),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {
                    controller.decrement();
                  }, icon: const Icon(Icons.remove)),
                  IconButton(onPressed: () {
                    controller.increment();
                  }, icon: const Icon(Icons.add)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
