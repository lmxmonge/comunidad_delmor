// lib/app/routes/app_pages.dart
import 'package:comunidad_delmor/app/presentation/views/contenedor/contenedor.dart';
import 'package:comunidad_delmor/app/presentation/views/perfil/perfil.dart';
import 'package:get/get.dart';

import '../views/home/home.dart';
import '../views/other_view/other_view.dart';
import '../views/login/login.dart';



part 'routes.dart';

class AppPages {
  AppPages._(); // Constructor privado para evitar instancias

  static const initial = Routes.login; // Ruta inicial

  static final routes = [
    GetPage(name: _Paths.contenedor, page: () => Contenedor()),
    GetPage(name: _Paths.home, page: () => HomeView()),
    GetPage(name: _Paths.other, page: () => OtherView()),
    GetPage(name: _Paths.perfil, page: () => Perfil()),
    GetPage(name: _Paths.login, page:() => Login())
  ];
}
