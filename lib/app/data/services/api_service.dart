import 'dart:convert';

import 'package:get/get_connect.dart' as getConnect;
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import 'package:intl/intl.dart';

abstract class ApiService {
  Future<dynamic> fetchDatosDaborales({required String userSap});

  Future<dynamic> fetchDatosUsuario({required String userSap});

  Future<dynamic> fetchCumpleanieros();

  Future<dynamic> cambiarContrasenia(String text, String codigoSap);

  Future<dynamic> fetchBoletinesInformativos();

  Future<dynamic> fetchCirculares({required String userSap});

  Future<dynamic> fetchMemorandums({required String userSap});

  Future<dynamic> sendTokenToServer(String token, String userSap);

  String _manejarRespuestaPost(http.Response response);
}

class ApiServiceImpl extends getConnect.GetConnect implements ApiService {
  @override
  Future<dynamic> fetchDatosDaborales({required String userSap}) async {
    try {
      // Realizar la solicitud HTTP GET
      var response = await http
          .get(Uri.parse('${ApiConstant.baseUrl}/datosLaborales/$userSap'));

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

  @override
  Future fetchCumpleanieros() async {
    try {
      var response =
          await http.get(Uri.parse('${ApiConstant.baseUrl}/Cumpleanieros'));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  @override
  Future fetchDatosUsuario({required String userSap}) async {
    try {
      // Realizar la solicitud HTTP GET
      var response = await http
          .get(Uri.parse('${ApiConstant.baseUrl}/getUserData/$userSap'));

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

  @override
  Future<String> cambiarContrasenia(String text, String codigoSap) async {
    // Formatear la fecha como 'YYYY-MM-DD'
    var fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Cuerpo del JSON que se enviará
    var jsonBody = jsonEncode({
      'data': [
        {
          "codigoSAP": codigoSap,
          "password": text,
          "fecha": fecha,
        }
      ]
    });

    print("Body: $jsonBody");
    print("URL: ${ApiConstant.baseUrl}/cambiarPassword");

    try {
      // Realizar la solicitud POST usando el paquete http
      final response = await http.post(
        Uri.parse('${ApiConstant.baseUrl}/cambiarPassword'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          // Tipo de contenido
        },
        body: {
          'json': jsonBody, // Enviar el JSON como campo de formulario
        },
      );

      return _manejarRespuestaPost(
          response); // Retornar el mensaje de la respuesta
    } catch (e) {
      print("Error en la solicitud: $e");
      throw Exception("Error al intentar cambiar la contraseña");
    }
  }

  @override
  _manejarRespuestaPost(http.Response response) {
    if (response.statusCode == 200) {
      return verMensaje(response);
    } else if (response.statusCode == 404) {
      throw Exception(verMensaje(response));
      throw Exception(jsonDecode(response.body)['message']);
    } else if (response.statusCode == 500) {
      throw Exception(verMensaje(response));
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  String verMensaje(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic> && body.containsKey('message')) {
        return body['message'] as String;
      }
    } catch (e) {
      // Manejo de errores en caso de que el body no sea JSON válido
      print("Error al decodificar el cuerpo de la respuesta: $e");
    }
    return response.reasonPhrase ?? 'Error desconocido';
  }

  @override
  Future fetchBoletinesInformativos() async {
    try {
      var response = await http
          .get(Uri.parse('${ApiConstant.baseUrl}/mostrarPdfBoletinAjax'));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  @override
  Future fetchCirculares({required String userSap}) async {
    try {
      var response = await http
          .get(Uri.parse('${ApiConstant.baseUrl}/mostrarPdfAjax/$userSap'));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  @override
  Future fetchMemorandums({required String userSap}) async {
    try {
      var response = await http
          .get(Uri.parse('${ApiConstant.baseUrl}/mostrarPdfMemoAjax/$userSap'));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  @override
  Future<String> sendTokenToServer(String token, String userSap) async {
    final url =
        '${ApiConstant.baseUrl}/guardarToken'; // Cambia esta URL por la URL de tu servidor PHP

    // Cuerpo del JSON que se enviará
    var jsonBody = jsonEncode({
      'data': [
        {
          "codigoSAP": userSap,
          "token": token,
        }
      ]
    });
    print("Body: $jsonBody");
    print("URL: ${ApiConstant.baseUrl}/cambiarPassword");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'json': jsonBody,
        },
      );

      return _manejarRespuestaPost(response);
    } catch (e) {
      print("Error en la solicitud: $e");
      throw Exception("Error al intentar enviar el token");
    }
  }
}
