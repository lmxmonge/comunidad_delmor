part of 'app_pages.dart';

abstract class Routes {
  static const contenedor = _Paths.contenedor;
  static const login = _Paths.login;
  static const other = _Paths.other;
  static const perfil = _Paths.perfil;
}

abstract class _Paths {
  static const contenedor = '/contenedor';
  static const home = '/home';
  static const login = '/login';
  static const other = '/other';
  static const perfil = '/perfil';
}