import 'package:get/get.dart';

class CustomDrawerController extends GetxController {

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  handleIndexChanged(int i) {
    if(i != _selectedIndex) Get.back();

    _selectedIndex = i;
    update(["navbar"]);

  }

}
