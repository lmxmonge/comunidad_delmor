import 'package:comunidad_delmor/app/data/models/counter_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<CounterModel> _counter = Rx<CounterModel>(CounterModel(0));

  CounterModel get counter => _counter.value;

  void increment() {
    _counter.value = CounterModel(counter.valor + 1);
  }

  void decrement() {
    print("valor: ${counter.valor}");
    if(counter.valor != 0)
    _counter.value = CounterModel(counter.valor - 1);
  }

}