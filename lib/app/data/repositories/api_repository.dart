import 'dart:convert';

import 'package:comunidad_delmor/app/data/models/cumpleanieros_model.dart';
import 'package:comunidad_delmor/app/data/models/datos_laborales_model.dart';
import 'package:comunidad_delmor/app/data/models/datos_usuario_model.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:get/get_connect/http/src/response/response.dart';
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

  Future<List<CumpleanierosModel>> fetchCumpleanieros() async {
    final jsonData = await _apiService.fetchCumpleanieros();

    if (jsonData is Map<String, dynamic> &&
        jsonData.containsKey('cumpleaneros')) {
      final cumpleanerosList = jsonData['cumpleaneros'];
      if (cumpleanerosList is List) {
        return cumpleanerosList
            .map((e) => CumpleanierosModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Error: 'cumpleaneros' no es una lista");
      }
    } else {
      throw Exception("Error al parsear los cumpleañeros");
    }
  }

  Future<String> cambiarContrasenia(String text) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final codigoSap = prefs.getString(Constantes.codigoSap) ?? '';
    late final String respuesta;

    try {
    respuesta = await _apiService.cambiarContrasenia(text, codigoSap);
    } catch (e) {
      throw Exception(e);
    }
     return respuesta;
  }
}
