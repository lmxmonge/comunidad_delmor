import 'package:comunidad_delmor/app/data/models/datos_laborales_model.dart';
import 'package:comunidad_delmor/app/data/models/datos_usuario_model.dart';
import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/utils/mediaQueryCustom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api/api_constant.dart';

class PerfilController extends GetxController {
  final ApiRespository respository;

  PerfilController(this.respository);

  var datosLaborales = Rxn<DatosLaboralesModel>();
  var datosUsuairo = Rxn<DatosUsuarioModel>();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchData();
  }

  Future<void> fetchDatosLaborales() async {
    try {
      datosLaborales.value = await respository.fetchDatosLaborales();

// datosLaborales.value?.salario = double.parse(datosLaborales.value?.salario).toStringAsFixed(2);

      print("datos:  ${datosLaborales.value}");
    } finally {}
  }

  Future<void> fetchDatosUsuario() async {
    try {
      datosUsuairo.value = await respository.fetchDatosUsuario();

      print("datos:  ${datosUsuairo.value}");
    } finally {}
  }

  Future<void> fetchData() async {
    isLoading(true);

    fetchDatosLaborales().then((value) {
      isLoading(false);

      fetchDatosUsuario().then((value) {
        isLoading(false);
      });
    });
  }
}
