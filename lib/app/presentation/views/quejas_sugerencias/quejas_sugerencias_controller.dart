import 'dart:async';

import 'package:comunidad_delmor/app/data/models/datos_usuario_model.dart';
import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/quejas_sugerencias_model.dart';

enum TipoComentarioEnum { queja, sugerencia }

class QuejasSugerenciasController extends GetxController {
  final ApiRespository respository;

  QuejasSugerenciasController(this.respository);

final Rx<TextEditingController> editingController = TextEditingController().obs;

  var isLoading = false.obs;

  // RxList<DatosUsuarioModel> datosUsuarioModel = <DatosUsuarioModel>[].obs;
  var datosUsuario = Rxn<DatosUsuarioModel>();

  var quejasSugerencias = Rxn<QuejasSugerenciasModel>();

  var remotePDFpath = "".obs;

  var tipoComentario = TipoComentarioEnum.queja.obs;

  var textFielErrorText = "".obs;

  void validarTexto() {
    if (editingController.value.text.isEmpty) {
      textFielErrorText.value = "Este campo no puede estar vacío";
    } else {
      textFielErrorText.value = "";

      editingController.value.text = "";
      enviarComentario();
    }
  }

  @override
  void onInit() {
    super.onInit();

    isLoading(true);

    fetchDatosUsuario().then((value) {
      isLoading(false);
      print("datos:  ${datosUsuario.value?.cumpleanios}");
    });
  }

  Future<void> fetchDatosUsuario() async {
    try {
      datosUsuario.value = await respository.fetchDatosUsuario();
    } finally {}
  }

  Future<void> enviarComentario() async {
    // isLoading(true);
    //mostrar barra de progreso
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
    );

    late final String respuesta;
    try {
      // datosUsuario.value = await respository.fetchDatosUsuario();

      respuesta = await respository
          .enviarComentario(datosUsuario.value, quejasSugerencias)
          .then((value) {
        cerrarBarraProgreso();
        dialogo(value, false);
        return value;
      });
    } catch (e) {

      cerrarBarraProgreso();
      respuesta = e.toString().split(':').last.trim();
      dialogo(respuesta, true);
    }
  }

  void dialogo(respuesta, bool error) {
    Get.generalDialog(pageBuilder: (context, animation, secondaryAnimation) {
      return AlertDialog(
        icon: Icon(
          error ? Icons.error : Icons.check,
          color: error ? Colors.red : Colors.green,
          size: 48.0,
        ),
        title: Text(!error ? 'Listo' : 'Alerta'),
        content: Text(respuesta),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Aceptar'),
          )
        ],
      );
    });
  }

  void cerrarBarraProgreso() {
    Get.back();
  }
}
