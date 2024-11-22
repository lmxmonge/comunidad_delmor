import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:comunidad_delmor/app/presentation/views/perfil/perfil_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PerfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiServiceImpl>(() => ApiServiceImpl());

    Get.lazyPut<ApiRespository>(
        () => ApiRespository(Get.find<ApiServiceImpl>()));

    Get.lazyPut<PerfilController>(
        () => PerfilController(Get.find<ApiRespository>()));
  }
}
