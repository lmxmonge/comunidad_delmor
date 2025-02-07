import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:comunidad_delmor/app/data/models/datos_usuario_model.dart';
import 'package:comunidad_delmor/app/data/models/quejas_sugerencias_model.dart';
import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart' as getConnect;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/views/boletin_informativo/boletin_informativo.dart';
import '../api/api_constant.dart';
import 'package:intl/intl.dart';

import '../api/api_response.dart';
import '../models/boletin_informativo_model.dart';

abstract class ApiService {
  Future<bool> checkInternetConnection();

  Future<dynamic> fetchDatosDaborales({required String userSap});

  Future<dynamic> fetchDatosUsuario({required String userSap});

  Future<dynamic> fetchCumpleanieros();

  Future<dynamic> cambiarContrasenia(Map<String, dynamic> json);

  Future<dynamic> fetchBoletinesInformativos();

  Future<dynamic> fetchCirculares({required String userSap});

  Future<dynamic> fetchMemorandums({required String userSap});

  Future<dynamic> enviarComentario(DatosUsuarioModel? datosUsuario,
      QuejasSugerenciasModel? quejasSugerencias);

  Future<dynamic> sendTokenToServer();

  Future<dynamic> chekActualizaciones();

  Future<String> _manejarRespuestaPost(http.Response response,
      {bool showDialog = true});
}

class ApiServiceImpl extends getConnect.GetConnect implements ApiService {
  @override
  Future<dynamic> fetchDatosDaborales({required String userSap}) async {
    try {
      // Realizar la solicitud HTTP GET

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');
      var response = await http.post(
          Uri.parse('${ApiConstant.baseUrlCesar}/datosLaborales/$userSap'),
          headers: { 'Authorization': 'Bearer ${accesTocken}',

          });

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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');

      var response = await http.post(
          Uri.parse('${ApiConstant.baseUrlCesar}/Cumpleanieros'),
          headers: {
            'Authorization': 'Bearer ${accesTocken}',
          });

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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');

      // Realizar la solicitud HTTP GET
      var response = await http.post(
          Uri.parse('${ApiConstant.baseUrlCesar}/getUserData/$userSap'),
          headers: {'Authorization': 'Bearer ${accesTocken}'});

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
  Future<String> cambiarContrasenia(Map<String, dynamic> json) async {
    // Formatear la fecha como 'YYYY-MM-DD'
    var fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Cuerpo del JSON que se enviará
    // var jsonBody = jsonEncode({
    //   'data': [
    //     {
    //       "codigoSAP": codigoSap,
    //       "password": text,
    //       "fecha": fecha,
    //     }
    //   ]
    // });

    var jsonBody = jsonEncode({
      'data': [
        {
          json,
        }
      ]
    });

    print("Body: $jsonBody");
    print("URL: ${ApiConstant.baseUrlCesar}/cambiarPassword");

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');

      // Realizar la solicitud POST usando el paquete http
      final response = await http.post(
        Uri.parse('${ApiConstant.baseUrl}/cambiarPassword'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accesTocken}',
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
  Future fetchBoletinesInformativos() async {
    try {
      var checkInternet = await checkInternetConnection();
      if (!checkInternet)
        throw ("No se pudo obtener boletines. Verifique su conexión de internet");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');

      var response = await http.post(
          Uri.parse(
            '${ApiConstant.baseUrlCesar}/getBoletines',
          ),
          headers: {
            'Authorization': 'Bearer ${accesTocken}',
          });

      if (response.statusCode != 200) {
        throw HttpException(
            'Error: ${response.statusCode} - ${response.reasonPhrase}');
      }

      var jsonData = jsonDecode(response.body);
      print(" Boletines: " + response.body);
      return jsonData;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future fetchCirculares({required String userSap}) async {
    try {
      var checkInternet = await checkInternetConnection();
      if (!checkInternet)
        throw ("No se pudo obtener circulares. Verifique su conexión de internet");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');

      var response = await http.post(
          Uri.parse(
            '${ApiConstant.baseUrlCesar}/getCirculares/$userSap',
          ),
          headers: {
            'Authorization': 'Bearer ${accesTocken}',
          });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future fetchMemorandums({required String userSap}) async {
    try {
      var checkInternet = await checkInternetConnection();
      if (!checkInternet)
        throw ("No se pudo obtener memorandums. Verifique su conexión de internet");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');

      var response = await http.post(
          Uri.parse(
            '${ApiConstant.baseUrlCesar}/getMemos/$userSap',
          ),
          headers: {
            'Authorization': 'Bearer ${accesTocken}',
          });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> sendTokenToServer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final codigoSap = prefs.getString(Constantes.codigoSap) ?? '';
    final tokenAndroid = prefs.getString(Constantes.tokenAndroid) ?? '';
    final tokenWeb = prefs.getString(Constantes.tokenWeb) ?? '';

    final url =
        '${ApiConstant.baseUrlCesar}/guardarToken'; // Cambia esta URL por la URL de tu servidor PHP

    // Cuerpo del JSON que se enviará
    var jsonBody = jsonEncode({
      'data': [
        {
          "codigoSAP": codigoSap,
          "tokenAndroid": tokenAndroid,
          "tokenWeb": tokenWeb
        }
      ]
    });
    print("Body: $jsonBody");
    print("URL: ${ApiConstant.baseUrlCesar}/sendToken");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      return _manejarRespuestaPost(response, showDialog: false);
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');

    var jsonBody = jsonEncode({
      'data': [
        {
          "idUsuario": datosUsuario?.usuarioSap,
          "nombre": datosUsuario?.nombres,
          "area": datosUsuario?.area,
          "comentario": quejasSugerencias?.comentario,
          "tipo": quejasSugerencias?.tipo,
          "fecha": fecha,
        }
      ]
    });

    try {
      // Realizar la solicitud POST usando el paquete http
      final response = await http.post(
        Uri.parse('${ApiConstant.baseUrlCesar}/guardarSugerencias'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${accesTocken}',
        },
        body: jsonBody,
      );

      return _manejarRespuestaPost(response);
    } catch (e) {
      print("$e");
      throw Exception("$e");
    }
  }

  @override
  Future<String> _manejarRespuestaPost(http.Response response,
      {bool showDialog = true}) async {
    try {
      if (response.body.isEmpty) {
        throw Exception(
            "Error al procesar la respuesta: ${response.reasonPhrase}");
      }
      print("Status code: ${response.statusCode} ");

      // Revisar si el status es diferente a 200
      final apiResponse = ApiResponse.fromJson(response.body);

      if (response.statusCode != 200) {
        throw HttpException("${apiResponse.message}");
      }

      if (apiResponse.status != 'success') {
        throw Exception(apiResponse.message);
      }

      return apiResponse.message;
    } on HttpException catch (e) {
      var mensaje = e.message.split(':').last.trim();

      if (!showDialog) throw Exception("$mensaje");

      // Usamos un Completer para esperar la acción del usuario
      final completer = Completer<void>();
      dialogo(
        mensaje,
        true,
        titulo: 'Avertencia',
        onTap: () {
          Get.back();
          completer.complete(); // Marca la acción como completada
        },
      );
      await completer
          .future; // Espera hasta que se llame a `completer.complete()`
      throw Exception("$mensaje");
    } on Exception catch (e) {
      print("Error al procesar la respuesta: $e");
      return "Error: $e";
    }
  }

  void dialogo(String mensaje, bool hasErrorIcon,
      {required String titulo, required VoidCallback onTap}) {
    Get.generalDialog(pageBuilder: (context, animation, secondaryAnimation) {
      return AlertDialog(
        title: Text(titulo),
        content: Text('$mensaje'),
        icon: hasErrorIcon == true
            ? const Icon(
                Icons.error,
                color: Colors.red,
                size: 48.0,
              )
            : const Icon(
                Icons.check,
                color: Colors.green,
                size: 48.0,
              ),
        actions: [
          TextButton(
            onPressed: () {
              onTap();
            },
            child: Text('Cerrar'),
          ),
        ],
      );
    });
  }

  @override
  Future chekActualizaciones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');

    try {
      // Realizar la solicitud HTTP GET

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // var accesTocken = (prefs.getString(Constantes.accesTocken) ?? '');
      var response = await http.post(
        Uri.parse('${ApiConstant.baseUrlCesar}/mostrarVersiones'),
        // headers: {
        //   'Authorization': 'Bearer ${accesTocken}',
        // }
      );

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
  Future<bool> checkInternetConnection() async {
    try {
      if (kIsWeb) return true;

      var response = await http.head(Uri.parse('https://www.google.com'));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
