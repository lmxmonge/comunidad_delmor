// lib/app/routes/app_pages.dart
import 'package:comunidad_delmor/app/presentation/views/quejas_sugerencias/quejas_sugerencias.dart';
import 'package:comunidad_delmor/app/presentation/views/quejas_sugerencias/quejas_sugerencias_binding.dart';
import 'package:comunidad_delmor/app/presentation/views/configuracion/configuracion_binding.dart';
import 'package:comunidad_delmor/app/presentation/views/contenedor/contenedor.dart';
import 'package:comunidad_delmor/app/presentation/views/contenedor/contenedor_bindig.dart';
import 'package:comunidad_delmor/app/presentation/views/cumpleanios/cumpleanios_binding.dart';
import 'package:comunidad_delmor/app/presentation/views/memorandums/memorandums_binding.dart';
import 'package:comunidad_delmor/app/presentation/views/notificaciones/notificaciones_bindig.dart';
import 'package:comunidad_delmor/app/presentation/views/pdf/pdf_web_view.dart';
import 'package:comunidad_delmor/app/presentation/views/perfil/perfil.dart';
import 'package:comunidad_delmor/utils/custom_transicion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/boletin_informativo/boletin_informativo_binding.dart';
import '../views/circulares/circulares_binding.dart';
import '../views/login/login_bindig.dart';
import '../views/home/home.dart';
import '../views/other_view/other_view.dart';
import '../views/login/login.dart';
import '../views/perfil/perfil_binding.dart';
import '../views/splash_page/spalsh_page.dart';
import '../views/splash_page/splash_bindig.dart';

part 'routes.dart';

class AppPages {
  AppPages._(); // Constructor privado para evitar instancias

  static const initial = Routes.splash; // Ruta inicial

  static final routes = [
    GetPage(name: _Paths.contenedor, page: () => Contenedor(), bindings: [
      NotificacionesBinding(),
      PerfilBinding(),
      CumpleaniosBinding(),
      ConfiguracionBinding(),
      CircularesBinding(),
      MemorandumsBinding(),
      BoletinInformativoBinding(),
      ContenedorBinding(),
    ]),
    GetPage(name: _Paths.home, page: () => HomeView()),
    GetPage(name: _Paths.other, page: () => const OtherView()),

    GetPage(
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      name: _Paths.login,
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    GetPage(
      // transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 300),
      name: _Paths.quejasSugerencias,
      page: () => QuejasSugerencias(),
      binding: QuejasSugerenciasBinding(),
      opaque: true,
      customTransition: CustomTransicion(),

    ),
    // GetPage(name: _Paths.pdf, page: () => PdfWebView())
  ];
}
