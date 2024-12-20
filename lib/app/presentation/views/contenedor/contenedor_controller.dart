import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/enlace_utils.dart';
import '../../../data/models/actualizacion_model.dart';
import '../../../data/repositories/api_repository.dart';

import '../../routes/app_pages.dart';

class ContenedorController extends GetxController {
  final ApiRespository respository;

  ContenedorController(this.respository);

  var actualizacion = ActualizacionModel(
          version: Constantes.versionAppQuemada, codigoInterno: 1, url: '')
      .obs;

  @override
  Future<void> onInit() async {
    estaLogueado();

    await checkActualizaciones();
    super.onInit();
  }

  Future<void> estaLogueado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var estaLogueado = prefs.getBool(Constantes.user) ?? false;

    if (!estaLogueado) {
      prefs.clear();
      // Eliminar el token del dispositivo
      await FirebaseMessaging.instance.deleteToken();
      print('Token de FCM eliminado.');
      Get.back();
      Get.offAllNamed(Routes.splash);
    }
  }

  Future<void> checkActualizaciones() async {
    await respository.checkActualizaciones().then((value) {
      actualizacion.value = value;

      EnlaceUtils.actualizarAppDialogo(
          codigoInternoApi: actualizacion.value.codigoInterno, url: actualizacion.value.url);
    });
  }
}
