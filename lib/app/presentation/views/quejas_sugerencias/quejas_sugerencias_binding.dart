import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:get/get.dart';

import 'quejas_sugerencias_controller.dart';

class QuejasSugerenciasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiServiceImpl>(() => ApiServiceImpl());

    Get.lazyPut<ApiRespository>(
        () => ApiRespository(Get.find<ApiServiceImpl>()));

    Get.lazyPut<QuejasSugerenciasController>(
        () => QuejasSugerenciasController(Get.find<ApiRespository>()));
  }
}
