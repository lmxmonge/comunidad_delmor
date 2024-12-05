import 'dart:convert';

import 'package:comunidad_delmor/app/data/models/datos_usuario_model.dart';
import 'package:comunidad_delmor/app/data/models/quejas_sugerencias_model.dart';
import 'package:get/get_connect.dart' as getConnect;
import 'package:http/http.dart' as http;

import '../api/api_constant.dart';
import 'package:intl/intl.dart';

import '../models/api_response.dart';

abstract class ApiService {
  Future<dynamic> fetchDatosDaborales({required String userSap});

  Future<dynamic> fetchDatosUsuario({required String userSap});

  Future<dynamic> fetchCumpleanieros();

  Future<dynamic> cambiarContrasenia(String text, String codigoSap);

  Future<dynamic> fetchBoletinesInformativos();

  Future<dynamic> fetchCirculares({required String userSap});

  Future<dynamic> fetchMemorandums({required String userSap});

  Future<dynamic> enviarComentario(DatosUsuarioModel? datosUsuario,
      QuejasSugerenciasModel? quejasSugerencias);

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
      throw Exception("$e");
    }
  }

  @override
  String _manejarRespuestaPost(http.Response response) {
    try {
      if (response.body.isEmpty) {
        throw Exception(
            "Error al procesar la respuesta: ${response.reasonPhrase}");
      }
      final apiResponse = ApiResponse.fromJson(response.body);

      if (apiResponse.status == 'error') throw Exception(apiResponse.message);

      return apiResponse.message;
    } on Exception catch (e) {
      print("Error al procesar la respuesta: $e");
      throw Exception("$e");
    }
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

  @override
  Future<String> enviarComentario(DatosUsuarioModel? datosUsuario,
      QuejasSugerenciasModel? quejasSugerencias) async {
    var fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());
    quejasSugerencias?.fecha = fecha;

    var jsonBody = jsonEncode({
      'data': [
        {
          "idUsuario": datosUsuario?.usuarioSap,
          "nombre": datosUsuario?.nombres,
          "area": datosUsuario?.area,
          "comentario": quejasSugerencias?.comentario,
          "tipo": quejasSugerencias?.tipo,
          "fecha": quejasSugerencias?.fecha,
        }
      ]
    });

    print("Body enviarComentario: $jsonBody");

    try {
      // Realizar la solicitud POST usando el paquete http
      final response = await http.post(
        Uri.parse('${ApiConstant.baseUrl}/guardarComentarios'),
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
      throw Exception("$e");
    }
  }
}
