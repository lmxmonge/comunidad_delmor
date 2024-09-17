part of 'app_pages.dart';

abstract class Routes {
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const other = _Paths.other;
}

abstract class _Paths {
  static const home = '/home';
  static const login = '/login';
  static const other = '/other';
}