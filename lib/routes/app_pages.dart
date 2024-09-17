// lib/app/routes/app_pages.dart
import 'package:get/get.dart';

import '../app/views/home/home.dart';
import '../app/views/other_view/other_view.dart';
part 'routes.dart';

class AppPages {
  AppPages._(); // Constructor privado para evitar instancias

  static const initial = Routes.home; // Ruta inicial

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () =>  HomeView(),
      // Puedes agregar bindings si necesitas inyectar dependencias
      // binding: HomeBinding(),
    ),

    GetPage(name: _Paths.other, page: () =>  OtherView()),
  ];
}
