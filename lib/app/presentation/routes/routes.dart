part of 'app_pages.dart';

abstract class Routes {
  static const contenedor = _Paths.contenedor;
  static const login = _Paths.login;
  static const other = _Paths.other;
  static const perfil = _Paths.perfil;
  static const home = _Paths.home;
  static const splash = _Paths.splash;
  static const pdf = _Paths.pdf;
  static const quejasSugerencias = _Paths.quejasSugerencias;
}

abstract class _Paths {
  static const contenedor = '/contenedor';
  static const home = '/home';
  static const login = '/login';
  static const other = '/other';
  static const perfil = '/perfil';
  static const splash = '/splash';
  static const pdf = '/pdf';
  static const quejasSugerencias = '/quejassugerencias';
}