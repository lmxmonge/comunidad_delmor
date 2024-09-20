// data/providers/login_provider.dart
import 'package:comunidad_delmor/app/data/api/api_constant.dart';
import 'package:get/get.dart';

class LoginProvider extends GetConnect {
  // Método para iniciar sesión
  Future<Response> login(String username, String password) {
    final body = {
      'username': username,
      'password': password,
    };

    return get('${ApiConstant.baseUrl}/${ApiConstant.loginEndpoint}/${username}/${password}');
  }

  Future<Response> estaLogueado(String username) {
    return get('${ApiConstant.baseUrl}/${ApiConstant.isLogged}/${username}');
  }
}
