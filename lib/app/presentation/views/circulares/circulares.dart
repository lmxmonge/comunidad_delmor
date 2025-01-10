import 'package:comunidad_delmor/app/data/models/circulares_model.dart';
import 'package:comunidad_delmor/utils/iconos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/sin_resultados/sin_resultados.dart';
import 'circulares_controller.dart';

class Circulares extends StatelessWidget {
  Circulares({super.key});

  final CircularesController controller = Get.find<CircularesController>();

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
            : controller.circulares.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () {
                      return controller.fetchCirculares();
                    },
                    child: ListView.builder(
                      itemCount: controller.circulares.length,
                      itemBuilder: (context, index) {
                        CircularesModel circular = controller.circulares[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Image.asset(Iconos.pdf, height: 50, width: 50,),
                              title: Text(circular.nombre),
                              subtitle: Text(circular.fechaEmision),
                              onTap: () {
                                controller.verPdf(circular);
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
              return controller.fetchCirculares();
            }),
      );
    });
  }

  boody(CircularesController controller) {
    var tituloEstilo = const TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
