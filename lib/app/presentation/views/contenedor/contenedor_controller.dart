import 'package:comunidad_delmor/app/data/models/user_model.dart';
import 'package:comunidad_delmor/app/data/services/api_service.dart';
import 'package:comunidad_delmor/app/data/services/preferencesService.dart';
import 'package:get/get.dart';

import '../../global_widgets/custom_drawer_controller/custom_drawer_controller.dart';

class ContenedorController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final PreferencesService preferencesService = Get.find<PreferencesService>();

  final CustomDrawerController customDrawer =
      Get.find<CustomDrawerController>();

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future<dynamic> getUserData() async {
    UserModel preferences = await preferencesService.getUser();

    print("Hola mundo: " + preferences.username);
  }
}
