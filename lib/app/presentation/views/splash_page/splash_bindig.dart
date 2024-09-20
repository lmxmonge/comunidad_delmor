import 'package:comunidad_delmor/app/presentation/views/splash_page/splash_page_controller.dart';
import 'package:get/get.dart';

import '../../../data/providers/login_provider.dart';
import '../../../data/repositories/login_repository.dart';
import '../../../data/services/login_service.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    print("SplashBinding - Inyectando dependencias");  // Este print debe ejecutarse
    Get.lazyPut<LoginProvider>(() => LoginProvider());
    Get.lazyPut<LoginService>(() => LoginService());
    Get.lazyPut<ILoginRepository>(() => LoginRepositoryImpl(Get.find<LoginService>()));
    Get.lazyPut(() => SplashPageController(Get.find<ILoginRepository>()));
  }
}

