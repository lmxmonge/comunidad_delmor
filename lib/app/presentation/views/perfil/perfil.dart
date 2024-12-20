import 'package:comunidad_delmor/app/presentation/global_widgets/sin_conexion/sin_conexion.dart';
import 'package:comunidad_delmor/app/presentation/views/perfil/perfil_controller.dart';
import 'package:comunidad_delmor/utils/iconos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtén el controlador usando Get.find() para que sea inyectado previamente por PerfilBinding
    final PerfilController controller = Get.find<PerfilController>();

    // return Center(child: const Text('No se encontraron datos'));
    return SingleChildScrollView(
      child: Center(
        child: Obx(() {
          // Mostrar un indicador de carga mientras se obtiene la información
          if (controller.isLoading.value) {
            return const LinearProgressIndicator();
          } else {
            // Una vez que los datos están cargados, mostrar la información
            if (controller.datosLaborales.value != null) {
              // return Text(controller.datosLaborales.value!.nombres.toString());
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    header(controller),
                    const SizedBox(
                      height: 15,
                    ),
                    boody(controller),
                  ],
                ),
              );
            } else {
              return const Text('No se encontraron datos');
            }
          }
        }),
      ),
    );
  }

  header(PerfilController controller) {
    var tituloEstilo = const TextStyle(
      fontSize: 20,
    );
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(Iconos.usuario),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          controller.datosLaborales.value?.nombres ?? '',
          style: tituloEstilo,
        ),
      ],
    );
  }

  boody(PerfilController controller) {
    var tituloEstilo = const TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        ocupacion(controller),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Información Básica",
              style: tituloEstilo,
            ),
          ),
        ),

        boodyItem(controller,
            iconPath: Iconos.seguroSocial,
            title: "INSS",
            content: controller.datosUsuairo.value?.inss.toString() ?? ''),

        boodyItem(controller,
            iconPath: Iconos.cedula,
            title: "Cédula",
            content: controller.datosUsuairo.value?.cedula ?? ''),

        boodyItem(controller,
            iconPath: Iconos.edad,
            title: "Edad",
            content: controller.datosLaborales.value?.edad ?? ''),
        boodyItem(controller,
            iconPath: Iconos.cumpleanios,
            title: "Cumpleaños",
            content: controller.datosLaborales.value?.cumpleanios ?? ''),
        boodyItem(controller,
            iconPath: Iconos.fechaInicio,
            title: "Fecha de Ingreso",
            content: controller.datosLaborales.value?.fechaDeIngreso ?? ''),
        // boodyItem(controller,
        //     iconPath: Iconos.fechaInicio,
        //     title: "Meses de Servicio",
        //     content: controller.datosLaborales.value?.mesesDeServicio ?? ''),
        boodyItem(controller,
            iconPath: Iconos.fechaInicio,
            title: "Tiempo de Servicio",
            content: formatearTiempoDeServicio(controller)),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Información Personal",
              style: tituloEstilo,
            ),
          ),
        ),
        boodyItem(controller,
            iconPath: Iconos.vacaciones,
            title: "Vacaciones",
            content:
            controller.datosLaborales.value?.vacacionesDisponibles ?? ''),
        boodyItem(
          controller,
          iconPath: Iconos.salario,
          title: "Salario",
          content: controller.datosLaborales.value?.salario != null
              ? double.parse(controller.datosLaborales.value!.salario)
              .toStringAsFixed(2)
              : '',
        ), //
        // boodyItem(controller,
        //     iconPath: Iconos.areaDeTrabajo,
        //     title: "Salario",
        //     content:'40000'),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  boodyItem(PerfilController controller,
      {required String iconPath,
        required String title,
        required String content}) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  iconPath,
                  width: 25,
                  height: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ocupacion(PerfilController controller) {
    return Container(
      width: double.infinity,
      // height: 100,
      padding: const EdgeInsets.all(5),
      child: Card(
        color: Color(0xff4C9F83),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Area",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                controller.datosLaborales.value?.area ?? '',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Cargo",
                style: TextStyle(color: Colors.white),
              ),

              Text(
                controller.datosLaborales.value?.ocupcacion ?? '',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),

            ],
          ),
        ),
      ),
    );
  }

  formatearTiempoDeServicio(PerfilController controller) {
    var meses = controller.datosLaborales.value?.mesesDeServicio ?? '0';
    var anios = controller.datosLaborales.value?.aniosDeServicio ?? '0';

    if (meses == '0' && anios == '0') {
      return '0 Meses';
    }
    else if (anios == '0' && meses != '0') {
      return '$meses Meses';
    }
    else if (meses == '0' && anios != '0') {
      return '$anios Años';
    }
    else if (meses != '0' && anios != '0') {
      return '$anios Años y $meses Meses';
    }
    else {
      return '0 Meses';
    }
  }
}