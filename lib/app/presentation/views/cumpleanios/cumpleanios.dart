import 'package:comunidad_delmor/app/data/models/cumpleanieros_model.dart';
import 'package:comunidad_delmor/app/presentation/views/cumpleanios/cumpleanios_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cumpleanios extends StatelessWidget {
  const Cumpleanios({super.key});

  @override
  Widget build(BuildContext context) {
    final CumpleaniosController controller = Get.find<CumpleaniosController>();
    return Obx(() {
      return Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
             colors: [
              Colors.blue,
              Colors.grey[300] as Color,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: controller.isLoading.value
            ? const LinearProgressIndicator()
            : controller.cumpleanieros.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.cumpleanieros.length,
                    itemBuilder: (context, index) {
                      return cummpleanieroCard(controller.cumpleanieros[index]);
                    },
                  )
                : Container(),
      );
    });
  }

  Widget cummpleanieroCard(CumpleanierosModel cumpleaniero) {
    var tituloStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      cumpleaniero.nombres,
                      style: tituloStyle,
                      softWrap: true,
                    ),
                  ),
                  Text(
                    cumpleaniero.cumpleanios,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Área: ${cumpleaniero.area}",
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Fecha Ingreso: ${cumpleaniero.fechaDeIngreso}",
                ),
              ),
              const SizedBox(height: 3),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Antigüedad: ${cumpleaniero.aniosDeServicio} años y ${cumpleaniero.mesesDeServicio} meses"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
