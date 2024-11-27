import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:get/get.dart';

import 'memorandums_controller.dart';

class MemorandumsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiServiceImpl>(() => ApiServiceImpl());

    Get.lazyPut<ApiRespository>(
        () => ApiRespository(Get.find<ApiServiceImpl>()));

    Get.lazyPut<MemorandumsController>(
        () => MemorandumsController(Get.find<ApiRespository>()));
  }
}
