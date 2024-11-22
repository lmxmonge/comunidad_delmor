import 'package:comunidad_delmor/app/data/models/datos_laborales_model.dart';
import 'package:comunidad_delmor/app/data/models/datos_usuario_model.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constantes.dart';

class ApiRespository {
  final ApiServiceImpl _apiService;

  ApiRespository(this._apiService);

  Future<DatosLaboralesModel> fetchDatosLaborales() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final jsonData = await _apiService.fetchDatosDaborales(
        userSap: prefs.getString(Constantes.codigoSap) ?? '');

    if (jsonData is Map<String, dynamic>) {
      return DatosLaboralesModel.fromJson(jsonData);
    } else {
      throw Exception("Error al parsear los datos laborales");
    }
  }

  Future<DatosUsuarioModel> fetchDatosUsuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final jsonData = await _apiService.fetchDatosUsuario(
        userSap: prefs.getString(Constantes.codigoSap) ?? '');

    if (jsonData is Map<String, dynamic>) {
      return DatosUsuarioModel.fromJson(jsonData);
    } else {
      throw Exception("Error al parsear los datos laborales");
    }
  }
}
