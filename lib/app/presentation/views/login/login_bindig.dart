// bindings/auth_binding.dart
import 'package:comunidad_delmor/app/data/repositories/login_repository.dart';
import 'package:get/get.dart';
import '../../../data/providers/login_provider.dart';
import '../../../data/services/login_service.dart';
import '../splash_page/splash_page_controller.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Inyectar LoginProvider
    Get.lazyPut<LoginProvider>(() => LoginProvider());
    // Inyectar LoginService usando el provider
    Get.lazyPut<LoginService>(() => LoginService());
    // Inyectar LoginRepositoryImpl usando el servicio
    Get.lazyPut<ILoginRepository>(() => LoginRepositoryImpl(Get.find<LoginService>()));
    // Inyectar LoginController usando el repositorio
    Get.lazyPut(() => LoginController(Get.find<ILoginRepository>()));

  }
}

