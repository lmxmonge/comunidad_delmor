import 'package:comunidad_delmor/app/data/services/login_service.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constantes.dart';

abstract class ILoginRepository {
  Future<Response> login(String username, String password);

  Future<Response> estaLogueado(String username);

  saveUser(data) async {}

  getUser() async {}

  isLogged() {}
}

class LoginRepositoryImpl implements ILoginRepository {
  final LoginService _loginService;

  LoginRepositoryImpl(this._loginService);

  @override
  Future<Response> login(String username, String password) {
    return _loginService.login(username, password);
  }

  @override
  Future<Response> estaLogueado(String username) {
    return _loginService.estaLogueado(username);
  }

  @override
  saveUser(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(Constantes.user, data.toString());
    await prefs.setBool(Constantes.isLogged, true);
  }

  @override
  getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constantes.user);
  }

  @override
  isLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(Constantes.isLogged);
  }
}
