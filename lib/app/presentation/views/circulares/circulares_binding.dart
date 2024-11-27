import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:get/get.dart';

import 'circulares_controller.dart';

class CircularesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiServiceImpl>(() => ApiServiceImpl());

    Get.lazyPut<ApiRespository>(
        () => ApiRespository(Get.find<ApiServiceImpl>()));

    Get.lazyPut<CircularesController>(
        () => CircularesController(Get.find<ApiRespository>()));
  }
}
