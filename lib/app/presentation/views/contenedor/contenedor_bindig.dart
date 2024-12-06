import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:comunidad_delmor/app/data/services/preferencesService.dart';
import 'package:comunidad_delmor/app/presentation/views/contenedor/contenedor_controller.dart';
import 'package:get/get.dart';

import '../../../data/repositories/api_repository.dart';

class ContenedorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiServiceImpl>(() => ApiServiceImpl());

    Get.lazyPut<ApiRespository>(
        () => ApiRespository(Get.find<ApiServiceImpl>()));
    Get.lazyPut<ContenedorController>(
        () => ContenedorController(Get.find<ApiRespository>()));
  }
}
