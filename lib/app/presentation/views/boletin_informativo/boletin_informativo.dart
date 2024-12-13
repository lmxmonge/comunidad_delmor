import 'package:comunidad_delmor/app/data/models/boletin_informativo_model.dart';
import 'package:comunidad_delmor/utils/iconos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'boletin_informativo_controller.dart';

class BoletinInformativo extends StatelessWidget {
  BoletinInformativo({super.key});

  final BoletinInformativoController controller =
      Get.find<BoletinInformativoController>();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtén el controlador usando Get.find() para que sea inyectado previamente por BoletinInformativoBinding

    // return Center(child: const Text('No se encontraron datos'));
    return Obx(() {
      return Container(
        decoration: BoxDecoration(),
        child: controller.isLoading.value
            ? const LinearProgressIndicator()
            : controller.boletines.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () {
                      return controller.fetchBoletines();
                    },
                  child: ListView.builder(
                      itemCount: controller.boletines.length,
                      itemBuilder: (context, index) {
                        BoletinIformativoModel boletin = controller.boletines[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(boletin.nombre),
                              subtitle:
                                  Text(boletin.fechaEmision),
                              onTap: () {
                                controller.verPdf(boletin);
                              },
                              enableFeedback: true,
                              trailing: const Icon(Icons.arrow_forward_ios),
                              isThreeLine: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                            ),
                            const Divider(
                              indent: 8,
                              endIndent: 8,
                            ),
                          ],
                        );
                      },
                    ),
                )
                : Container(),
      );
    });
  }

  boody(BoletinInformativoController controller) {
    var tituloEstilo = const TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    );
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
