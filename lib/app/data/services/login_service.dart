import 'package:comunidad_delmor/app/data/models/user_model.dart';
import 'package:get/get.dart';

import '../providers/login_provider.dart';

class LoginService {
  final LoginProvider _loginProvider = Get.find<LoginProvider>();

  Future<Response> login(String username, String password) {
    return _loginProvider.login(username, password);
  }

  Future<Response> estaLogueado(String username) {
    return _loginProvider.estaLogueado(username);
  }
}
