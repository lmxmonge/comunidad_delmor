import 'dart:convert';

import 'package:comunidad_delmor/app/data/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class LoginController extends GetxController {
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
        errorMessage.value =
            response.body['message'] ?? 'Error al verificar si el usuario está logueado';
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

      if (response.statusCode != 200) {
        errorMessage.value = 'Error al iniciar sesión';
        dialogoError();
        return;
      }

      Map<String, dynamic> data = jsonDecode(response.body);
      print("data: $data");

      if (data['user'] != true || data['user'] == null) {
        errorMessage.value = 'Usuario o contraseña incorrectos';
        dialogoError();
        return;
      }

      await _loginRepository.saveUser(data['user']);

      Get.offNamed(Routes.contenedor);
    } catch (e) {
      errorMessage.value = 'Error: $e';
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
}
// LMonge780
