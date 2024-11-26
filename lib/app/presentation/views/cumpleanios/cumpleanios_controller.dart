import 'package:comunidad_delmor/app/data/providers/login_provider.dart';
import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/models/cumpleanieros_model.dart';

class CumpleaniosController extends GetxController {
  final ApiRespository respository;

  CumpleaniosController(this.respository);

  RxList<CumpleanierosModel> cumpleanieros = <CumpleanierosModel>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading(true);
    fetchCumpleanieros().then((value) {
      isLoading(false);
    });
  }

  Future<void> fetchCumpleanieros() async {
    try {
      cumpleanieros.value = await respository.fetchCumpleanieros();

      print("datos cumpleanios:  ${cumpleanieros.first}");
    } finally {}
  }
}
