import 'package:comunidad_delmor/app/data/models/datos_laborales_model.dart';
import 'package:comunidad_delmor/app/data/models/datos_usuario_model.dart';
import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  final ApiRespository respository;

  PerfilController(this.respository);

  var datosLaborales = Rxn<DatosLaboralesModel>();
  var datosUsuairo = Rxn<DatosUsuarioModel>();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading(true);

    fetchDatosLaborales().then((value) {
      isLoading(false);

      fetchDatosUsuario().then((value) {
        isLoading(false);
      });
    });
  }

  Future<void> fetchDatosLaborales() async {
    try {
      datosLaborales.value = await respository.fetchDatosLaborales();

      print("datos:  ${datosLaborales.value}");
    } finally {}
  }

  Future<void> fetchDatosUsuario() async {
    try {
      datosUsuairo.value = await respository.fetchDatosUsuario();

      print("datos:  ${datosUsuairo.value}");
    } finally {}
  }
}
