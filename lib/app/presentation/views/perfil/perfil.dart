import 'dart:math';

import 'package:comunidad_delmor/app/presentation/global_widgets/sin_conexion/sin_conexion.dart';
import 'package:comunidad_delmor/app/presentation/views/perfil/perfil_controller.dart';
import 'package:comunidad_delmor/utils/iconos.dart';
import 'package:comunidad_delmor/utils/mediaQueryCustom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

late double contenidoTamanio;

late double tituloTamanio;
late double diagonal;

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryCustom.initMediaQueryCustom(context);

    void initTamanioLetras() {
      if (MediaQueryCustom.isMediumScreen) {
        tituloTamanio = MediaQueryCustom.diagonal * 0.014;
        contenidoTamanio = MediaQueryCustom.diagonal * 0.014;
      } else {
        tituloTamanio = 16;
        contenidoTamanio = 16;
      }
    }

    initTamanioLetras();
    // Obtén el controlador usando Get.find() para que sea inyectado previamente por PerfilBinding
    final PerfilController controller = Get.find<PerfilController>();

    return RefreshIndicator(
      onRefresh: () {
        return controller.fetchData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                      // if (MediaQueryCustom.isSmallScreen)
                      //   boodySmall(controller, context)
                      // else
                        bodyNormal(controller, context),
                    ],
                  ),
                );
              } else {
                return const Text('No se encontraron datos');
              }
            }
          }),
        ),
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

  bodyNormal(PerfilController controller, BuildContext context) {
    var tituloEstilo = TextStyle(
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

        bodyItem2(
            context: context,
            controller,
            iconPath: Iconos.cedula,
            title: "Cédula",
            content: controller.datosUsuairo.value?.cedula ?? '',

            iconPath2: Iconos.seguroSocial,
            title2: "INSS",
            content2: controller.datosUsuairo.value?.inss.toString() ?? ''),

        // bodyItem(
        //     context: context,
        //     controller,
        //     iconPath: Iconos.cedula,
        //     title: "Cédula",
        //     content: controller.datosUsuairo.value?.cedula ?? ''),

        bodyItem2(controller,
            context: context,
            iconPath2: Iconos.edad,
            title2: "Edad",
            content2: controller.datosLaborales.value?.edad ?? '',
            iconPath: Iconos.cumpleanios,
            title: "Fecha de Nacimiento",
            content: controller.datosLaborales.value?.cumpleanios ?? ''),
        bodyItem2(controller,
            context: context,
            iconPath: Iconos.fechaInicio,
            title: "Fecha de Ingreso",
            content: controller.datosLaborales.value?.fechaDeIngreso ?? '',
            iconPath2: Iconos.fechaInicio,
            title2: "Tiempo de Servicio",
            content2: formatearTiempoDeServicio(controller)),
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
        bodyItem2(
            context: context,
            controller,
            iconPath: Iconos.vacaciones,
            title: "Vacaciones",
            content:
                controller.datosLaborales.value?.vacacionesDisponibles ?? '',

            iconPath2: Iconos.salario,
            title2: "Salario",
            content2: controller.datosLaborales.value?.salario != null
                ? double.parse(controller.datosLaborales.value!.salario)
                .toStringAsFixed(2)
                : ''
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  bodySmall(PerfilController controller, BuildContext context) {
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

        bodyItem(
            context: context,
            controller,
            iconPath: Iconos.seguroSocial,
            title: "INSS",
            content: controller.datosUsuairo.value?.inss.toString() ?? ''),

        bodyItem(
            context: context,
            controller,
            iconPath: Iconos.cedula,
            title: "Cédula",
            content: controller.datosUsuairo.value?.cedula ?? ''),

        bodyItem(
            context: context,
            controller,
            iconPath: Iconos.cumpleanios,
            title: "Fecha de Nacimiento",
            content: controller.datosLaborales.value?.cumpleanios ?? ''),

        bodyItem(
          context: context,
          controller,
          iconPath: Iconos.edad,
          title: "Edad",
          content: controller.datosLaborales.value?.edad ?? '',
        ),

        bodyItem(
          context: context,
          controller,
          iconPath: Iconos.fechaInicio,
          title: "Fecha de Ingreso",
          content: controller.datosLaborales.value?.fechaDeIngreso ?? '',
        ),

        bodyItem(
            context: context,
            controller,
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
        bodyItem(
            context: context,
            controller,
            iconPath: Iconos.vacaciones,
            title: "Vacaciones",
            content:
                controller.datosLaborales.value?.vacacionesDisponibles ?? ''),
        bodyItem(
          context: context,
          controller,
          iconPath: Iconos.salario,
          title: "Salario",
          content: controller.datosLaborales.value?.salario != null
              ? double.parse(controller.datosLaborales.value!.salario)
                  .toStringAsFixed(2)
              : '',
        ), //

        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  bodyItem(
    PerfilController controller, {
    required BuildContext context,
    required String iconPath,
    required String title,
    required String content,
  }) {
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
                    style: TextStyle(fontSize: contenidoTamanio),
                  ),
                  Text(
                    content,
                    style: TextStyle(fontSize: contenidoTamanio),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bodyItem2(
    PerfilController controller, {
    required String iconPath,
    required String title,
    required String content,
    required String iconPath2,
    required String title2,
    required String content2,
    required BuildContext context,
  }) {
    var size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        maxHeight: 75,
        maxWidth: size.width,
      ),
      width: size.width,
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              // runSpacing: 3,
              // crossAxisAlignment: WrapCrossAlignment.end,

              // mainAxisAlignment:MainAxisAlignment.spaceAround,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
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
                            style: TextStyle(fontSize: tituloTamanio),
                          ),
                          Text(
                            content,
                            style: TextStyle(fontSize: contenidoTamanio),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Positioned(
                  top: 0,
                  left: size.width * 0.47,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          iconPath2,
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
                            title2,
                            style: TextStyle(fontSize: tituloTamanio),
                          ),
                          Text(
                            content2,
                            style: TextStyle(fontSize: contenidoTamanio),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
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
    } else if (anios == '0' && meses != '0') {
      return '$meses Meses';
    } else if (meses == '0' && anios != '0') {
      return '$anios Años';
    } else if (meses != '0' && anios != '0') {
      return '$anios Años y $meses Meses';
    } else {
      return '0 Meses';
    }
  }
}
