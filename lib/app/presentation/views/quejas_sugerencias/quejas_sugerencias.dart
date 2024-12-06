import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colores.dart';
import 'quejas_sugerencias_controller.dart';

class QuejasSugerencias extends StatelessWidget {
  QuejasSugerencias({super.key});

  final QuejasSugerenciasController controller =
      Get.find<QuejasSugerenciasController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: controller.isLoading.value
            ? const LinearProgressIndicator()
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Quejas y Sugerencias'),
                  actions: [],
                ),
                body: SingleChildScrollView(
                  child: _buildBody(),
                ),
              ),
      );
    });
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return TextField(
              controller: controller.editingController.value,
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.start,
              maxLines: 2,
              decoration: InputDecoration(
                errorText: controller.textFielErrorText.value.isEmpty
                    ? null
                    : controller.textFielErrorText.value,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                border: const OutlineInputBorder(),
                labelText: 'Escribe tu comentario',
              ),
            );
          }),
          const SizedBox(height: 15),
          const Text(
            'Tipo de comentario',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Obx(() {
            return Column(
              children: TipoComentarioEnum.values.map((tipo) {
                return RadioListTile<TipoComentarioEnum>(
                  activeColor: Colors.deepPurple,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  title: Text(tipo.name.capitalizeFirst!),
                  value: tipo,
                  groupValue: controller.tipoComentario.value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.tipoComentario.value = value;
                    }
                  },
                );
              }).toList(),
            );
          }),
          const SizedBox(height: 15),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: CupertinoButton(
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colores.secondary,
                // ),
                // padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                color: Colores.secondary,
                onPressed: () {
                  controller.validarTexto();
                },
                child: const Text(
                  "Enviar",
                  style: TextStyle(color: Colores.white),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
