import 'package:comunidad_delmor/utils/iconos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'configuracion_controller.dart';

class Configuracion extends StatelessWidget {
  Configuracion({super.key});

  final ConfiguracionController controller =
      Get.find<ConfiguracionController>();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtén el controlador usando Get.find() para que sea inyectado previamente por ConfiguracionBinding

    // return Center(child: const Text('No se encontraron datos'));
    return SingleChildScrollView(
      child: Center(
        child:SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              boody(controller),
            ],
          ),
        )
      ),
    );
  }

  boody(ConfiguracionController controller) {
    var tituloEstilo = const TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Opciones de Usuario",
              style: tituloEstilo,
            ),
          ),
        ),
        boodyItem(
            iconPath: Iconos.candado,
            title: "Cambiar Contraseña",
            content: "Cambiar la contraseña de acceso"),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  boodyItem(
      {required String iconPath,
      required String title,
      required String content}) {
    return Column(
      children: [
        ListTile(
          trailing: const Icon(Icons.arrow_forward_ios),
          leading: Image.asset(
            iconPath,
            width: 25,
            height: 25,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
          onTap: () {
            showDialog();
          },
        ),
        const Divider(
          endIndent: 10,
          indent: 10,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  showDialog() {
    final _formKey = GlobalKey<FormState>();

    Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          title: const Text("Cambiar Contraseña"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => TextFormField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Nueva Contraseña",
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.passwordVisivility.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.changePasswordVisibility,
                      ),
                    ),
                    obscureText: !controller.passwordVisivility.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "La nueva contraseña es obligatoria";
                      }
                      if (value.length < 4) {
                        return "Debe tener al menos 4 caracteres";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    controller: _repeatPasswordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Repetir Contraseña",
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.repeatPasswordVisivility.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.changeRepeatPasswordVisibility,
                      ),
                    ),
                    obscureText: !controller.repeatPasswordVisivility.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Repetir contraseña es obligatorio";
                      }
                      if (value != _newPasswordController.text) {
                        return "Las contraseñas no coinciden";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {

                  controller.changePassword(_newPasswordController.text);
                }
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}
