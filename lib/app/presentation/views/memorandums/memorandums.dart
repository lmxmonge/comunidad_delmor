import 'package:comunidad_delmor/app/data/models/memorandums_model.dart';
import 'package:comunidad_delmor/utils/iconos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/memorandums_model.dart';
import 'memorandums_controller.dart';

class Memorandums extends StatelessWidget {
  Memorandums({super.key});

  final MemorandumsController controller =
      Get.find<MemorandumsController>();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtén el controlador usando Get.find() para que sea inyectado previamente por MemorandumsBinding

    // return Center(child: const Text('No se encontraron datos'));
    return Obx(() {
      return Container(
        decoration: BoxDecoration(),
        child: controller.isLoading.value
            ? const LinearProgressIndicator()
            : controller.memorandums.isNotEmpty
                ? RefreshIndicator(
          onRefresh: (){
            return controller.fetchMemorandums();
          },
                  child: ListView.builder(
                      itemCount: controller.memorandums.length,
                      itemBuilder: (context, index) {
                        MemorandumsModel circular = controller.memorandums[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Image.asset(Iconos.pdf, height: 50, width: 50,),
                              title: Text(circular.nombre),
                              subtitle:
                                  Text(circular.fechaEmision),
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
                : Container(),
      );
    });
  }

  boody(MemorandumsController controller) {
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
