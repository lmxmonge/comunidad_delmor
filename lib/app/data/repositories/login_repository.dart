import 'package:comunidad_delmor/app/data/models/user_model.dart';
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

    bool user = data['user'] ?? false;
    int idUsuario = data['idusuario'] ?? 0;
    int codigoSap = data['codigoSAP'] ?? 0;
    String username = data['username'] ?? '';
    String password = data['password'] ?? '';

    int logged = data['logged'] ?? '';
    String token = data['accessToken'] ?? '';
    bool status = data['status'] ?? '';

    await prefs.setBool(Constantes.user, user);
    await prefs.setString(Constantes.idUsuario, idUsuario.toString());
    await prefs.setString(Constantes.codigoSap, codigoSap.toString());
    await prefs.setBool(Constantes.isLogged, true);
    await prefs.setString(Constantes.userName, username);
    await prefs.setString(Constantes.password, password);

    await prefs.setInt(Constantes.logged, logged);
    await prefs.setString(Constantes.accesTocken, token);
    await prefs.setBool(Constantes.status, status);

  }

  @override
  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    UserModel userModel = UserModel(
      idUsuario: prefs.getString(Constantes.idUsuario) ?? '',
      codigoSap: prefs.getString(Constantes.codigoSap) ?? '',
      username: prefs.getString(Constantes.userName) ?? '',
      password: prefs.getString(Constantes.password) ?? '',
    );

    return userModel;
  }

  @override
  isLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constantes.isLogged);
  }
}
// {"idusuario":272,"codigoSAP":780,"logged":1,"user":true}
