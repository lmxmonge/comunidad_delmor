// lib/app/routes/app_pages.dart
import 'package:comunidad_delmor/app/presentation/views/contenedor/contenedor.dart';
import 'package:comunidad_delmor/app/presentation/views/perfil/perfil.dart';
import 'package:get/get.dart';

import '../views/login/login_bindig.dart';
import '../views/home/home.dart';
import '../views/other_view/other_view.dart';
import '../views/login/login.dart';
import '../views/splash_page/spalsh_page.dart';
import '../views/splash_page/splash_bindig.dart';

part 'routes.dart';

class AppPages {
  AppPages._(); // Constructor privado para evitar instancias

  static const initial = Routes.splash; // Ruta inicial

  static final routes = [
    GetPage(name: _Paths.contenedor, page: () => const Contenedor()),
    GetPage(name: _Paths.home, page: () => HomeView()),
    GetPage(name: _Paths.other, page: () => const OtherView()),
    GetPage(name: _Paths.perfil, page: () => const Perfil()),
    GetPage(
      name: _Paths.login,
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
  ];
}
