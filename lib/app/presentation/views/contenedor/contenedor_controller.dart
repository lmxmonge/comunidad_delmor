import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/enlace_utils.dart';
import '../../../data/api/api_constant.dart';
import '../../../data/repositories/api_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ContenedorController extends GetxController {
  final ApiRespository respository;

  ContenedorController(this.respository);

  @override
  void onInit() {
    EnlaceUtils.actualizarAppDialogo();
    super.onInit();
  }
}
