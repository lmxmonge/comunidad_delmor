import 'package:comunidad_delmor/app/data/models/circulares_model.dart';
import 'package:comunidad_delmor/utils/iconos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../pdf/pdfView.dart';
import 'circulares_controller.dart';

class Circulares extends StatelessWidget {
  Circulares({super.key});

  final CircularesController controller =
      Get.find<CircularesController>();

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
                ? ListView.builder(
                    itemCount: controller.circulares.length,
                    itemBuilder: (context, index) {
                      CircularesModel circular = controller.circulares[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(circular.nombre),
                            subtitle:
                                Text(circular.fechaEmision),
                            onTap: () {
                              // Get.to(() => Pdf(
                              //     initialPath: controller.circulares[index].url));

                              // Get.to(Perfil2());


                              // if (controller.remotePDFpath.isNotEmpty)
                              //   Get.to(Pdf2(
                              //     path: controller.remotePDFpath.toString(),
                              //   ));

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
                  )
                : Container(),
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