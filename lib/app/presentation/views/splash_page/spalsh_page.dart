import 'package:comunidad_delmor/app/presentation/views/splash_page/splash_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: GetBuilder<SplashPageController>(builder: (_) {
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
