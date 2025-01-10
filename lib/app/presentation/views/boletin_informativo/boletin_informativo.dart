import 'package:comunidad_delmor/app/data/models/boletin_informativo_model.dart';
import 'package:comunidad_delmor/app/presentation/global_widgets/sin_resultados/sin_resultados.dart';
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
                        BoletinIformativoModel boletin =
                            controller.boletines[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                Iconos.pdf,
                                height: 50,
                                width: 50,
                              ),
                              title: Text(boletin.nombre),
                              subtitle: Text(boletin.fechaEmision),
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
                : RefreshIndicator(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),

                      child: SinResultados(
                        cuerpo: controller.sinResultados.value,
                      ),
                    ),
                    onRefresh: () {
                      return controller.fetchBoletines();
                    }),
      );
    });
  }
}
