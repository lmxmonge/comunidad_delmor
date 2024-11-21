import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constantes.dart';
import '../models/user_model.dart';

abstract class PreferencesService {
  getUser() async {}
}

class PrefencesServiceImpl extends PreferencesService {
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
}
