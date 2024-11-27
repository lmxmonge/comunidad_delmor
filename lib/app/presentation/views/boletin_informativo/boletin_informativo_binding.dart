import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:get/get.dart';

import 'boletin_informativo_controller.dart';

class BoletinInformativoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiServiceImpl>(() => ApiServiceImpl());

    Get.lazyPut<ApiRespository>(
        () => ApiRespository(Get.find<ApiServiceImpl>()));

    Get.lazyPut<BoletinInformativoController>(
        () => BoletinInformativoController(Get.find<ApiRespository>()));
  }
}
