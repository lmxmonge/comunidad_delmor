import 'package:comunidad_delmor/app/data/models/actualizacion_model.dart';
import 'package:comunidad_delmor/app/data/api/api_response.dart';
import 'package:comunidad_delmor/app/data/models/boletin_informativo_model.dart';
import 'package:comunidad_delmor/app/data/models/circulares_model.dart';
import 'package:comunidad_delmor/app/data/models/contrasenia_model.dart';
import 'package:comunidad_delmor/app/data/models/cumpleanieros_model.dart';
import 'package:comunidad_delmor/app/data/models/datos_laborales_model.dart';
import 'package:comunidad_delmor/app/data/models/datos_usuario_model.dart';
import 'package:comunidad_delmor/app/data/models/memorandums_model.dart';
import 'package:comunidad_delmor/app/data/models/quejas_sugerencias_model.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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

  Future<String> cambiarContrasenia(ContraseniaModel contraseniaModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final codigoSap = prefs.getString(Constantes.codigoSap) ?? '';
    late final String respuesta;

    try {
      respuesta = await _apiService.cambiarContrasenia(
        contraseniaModel.copyWith(codigoSap: codigoSap).toJson(),
      );
    } catch (e) {
      throw Exception(e);
    }
    return respuesta;
  }

  Future<ApiResponse> fetchBoletinesInformativos() async {
    try {
      final jsonData = await _apiService.fetchBoletinesInformativos();

      // // Validar respuesta y transformarla
      if (jsonData['status'] == "error") {
        return ApiResponse(
          status: jsonData['status'],
          message: jsonData['message'] ?? 'Error desconocido',
        );
      }

      if (!jsonData.containsKey('boletines') ||
          jsonData['boletines'] is! List) {
        throw Exception("Error al parsear los boletines");
      }

      // Parsear y retornar boletines
      final boletines = (jsonData['boletines'] as List)
          .map((e) => BoletinIformativoModel.fromJson(e))
          .toList();

      ApiResponse apiResponse = ApiResponse(status: 'susses', message: 'OK');
      apiResponse.setData(boletines);
      return apiResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ApiResponse> fetchCirculares() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final jsonData = await _apiService.fetchCirculares(
          userSap: prefs.getString(Constantes.codigoSap) ?? '');

      if (jsonData['status'] == "error") {
        return ApiResponse(
          status: jsonData['status'],
          message: jsonData['message'] ?? 'Error desconocido',
        );
      }

      if (!jsonData.containsKey('circulares') ||
          jsonData['circulares'] is! List) {
        throw Exception("Error al parsear circulares");
      }

      // Parsear y retornar boletines
      final circulares = (jsonData['circulares'] as List)
          .map((e) => CircularesModel.fromJson(e))
          .toList();

      ApiResponse apiResponse = ApiResponse(status: 'susses', message: 'OK');
      apiResponse.setData(circulares);
      return apiResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ApiResponse> fetchMemorandums() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final jsonData = await _apiService.fetchMemorandums(
          userSap: prefs.getString(Constantes.codigoSap) ?? '');

      // // Validar respuesta y transformarla
      if (jsonData['status'] == "error") {
        return ApiResponse(
          status: jsonData['status'],
          message: jsonData['message'] ?? 'Error desconocido',
        );
      }

      if (!jsonData.containsKey('memoramdums') ||
          jsonData['memoramdums'] is! List) {
        throw Exception("Error al parsear memoramdums");
      }

      // Parsear y retornar boletines
      final boletines = (jsonData['memoramdums'] as List)
          .map((e) => BoletinIformativoModel.fromJson(e))
          .toList();

      ApiResponse apiResponse = ApiResponse(status: 'susses', message: 'OK');
      apiResponse.setData(boletines);
      return apiResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> enviarComentario(DatosUsuarioModel? value,
      Rxn<QuejasSugerenciasModel> quejasSugerencias) async {
    late final String respuesta;

    try {
      respuesta =
          await _apiService.enviarComentario(value, quejasSugerencias.value);
      return respuesta;
    } on Exception catch (e, s) {
      throw Exception(e);
    }
  }

  Future<ActualizacionModel> checkActualizaciones() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    final jsonData = await _apiService.chekActualizaciones();

    if (jsonData is Map<String, dynamic>) {
      return ActualizacionModel.fromJson(jsonData);
    } else {
      throw Exception("Error al parsear la actualización");
    }
  }
}
