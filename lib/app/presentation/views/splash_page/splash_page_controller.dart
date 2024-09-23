import 'package:get/get.dart';

import '../../../data/repositories/login_repository.dart';
import '../../routes/app_pages.dart';

class SplashPageController extends GetxController {
  final ILoginRepository _loginRepository;
  SplashPageController(this._loginRepository);

  @override
  onInit() {
    super.onInit();
    print("SplashPageController - Inicializado");
    isLogged();
  }



  Future<void> isLogged() async {
    bool? isLogged = await _loginRepository.isLogged();
    print("isLogged: $isLogged");
    await Future.delayed(const Duration(milliseconds: 500));

    if (isLogged ?? false) {
      Get.offNamed(Routes.contenedor); // Redirigir al contenedor si está logueado
    } else {
      Get.offNamed(Routes.login); // Redirigir al login si no está logueado
    }
  }
}

