import 'dart:convert';

import 'package:comunidad_delmor/app/data/models/data_user.dart';
import 'package:http/http.dart';

import '../api/api_constant.dart';

abstract class ApiService {
  Future<dynamic> fetchDataUser({required String userSap});
}

class ApiServiceImpl implements ApiService {
  @override
  Future<dynamic> fetchDataUser({required String userSap}) async {
    try {
      // Realizar la solicitud HTTP GET
      var response =
          await get(Uri.parse('${ApiConstant.baseUrl}/getUserData/$userSap'));

      if (response.statusCode == 200) {
        // Si la respuesta es exitosa (código 200), parsear el JSON
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        // Si la respuesta no es exitosa, devolver el código de error o mensaje
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      // Manejar cualquier excepción que ocurra durante la solicitud
      return 'Error: $e';
    }
  }
}
