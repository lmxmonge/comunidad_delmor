import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:comunidad_delmor/app/data/services/preferencesService.dart';
import 'package:get/get.dart';

class ContenedorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiServiceImpl>(() => ApiServiceImpl());
    Get.lazyPut<PrefencesServiceImpl>(() => PrefencesServiceImpl());
  }
}
