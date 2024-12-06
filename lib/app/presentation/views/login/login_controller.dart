import 'dart:convert';

import 'package:comunidad_delmor/app/data/api/api_constant.dart';
import 'package:comunidad_delmor/app/data/repositories/login_repository.dart';
import 'package:comunidad_delmor/utils/enlace_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    EnlaceUtils.actualizarAppDialogo();
    super.onInit();
  }

  final ILoginRepository _loginRepository;

  LoginController(this._loginRepository);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Método para manejar el login
  Future<void> estaLogueado(String username, String password) async {
    try {
      final Response response = await _loginRepository.estaLogueado(username);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data['userUsed'] == false) login(username, password);
      } else {
        errorMessage.value = response.body['message'] ??
            'Error al verificar si el usuario está logueado';
        print(errorMessage.value);
        dialogoError();
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;

    try {
      final response = await _loginRepository.login(username, password);

      // print(response.body);
      if (response.statusCode != 200) {
        errorMessage.value = 'Error al iniciar sesión';
        dialogoError();
        return;
      }

      Map<String, dynamic> data = jsonDecode(response.body);

      if (data['user'] != true || data['user'] == null) {
        errorMessage.value = 'Usuario o contraseña incorrectos';
        dialogoError();
        return;
      }

      data['username'] = username;
      data['password'] = password;

      await _loginRepository.saveUser(data);

      Get.offNamed(Routes.contenedor);
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  void dialogoError() {
    Get.defaultDialog(
      title: 'Error',
      content: Text(errorMessage.value),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }

  Future<dynamic> getUser() async {
    return await _loginRepository.getUser();
  }
}
// LMonge780
//{"idusuario":272,"codigoSAP":780,"logged":1,"user":true}
