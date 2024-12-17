import 'package:comunidad_delmor/app/presentation/views/boletin_informativo/boletin_informativo.dart';
import 'package:comunidad_delmor/app/presentation/views/configuracion/configuracion.dart';
import 'package:comunidad_delmor/app/presentation/views/cumpleanios/cumpleanios.dart';
import 'package:comunidad_delmor/app/presentation/views/memorandums/memorandums.dart';
import 'package:comunidad_delmor/app/presentation/views/perfil/perfil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/repositories/api_repository.dart';
import '../../../data/services/api_service.dart';
import '../../routes/app_pages.dart';
import '../../global_widgets/custom_drawer_controller/custom_drawer.dart';
import '../../global_widgets/custom_drawer_controller/custom_drawer_controller.dart';
import '../circulares/circulares.dart';
import '../quejas_sugerencias/quejas_sugerencias.dart';
import '../notificaciones/notificaciones_controller.dart';
import '../perfil/perfil_controller.dart';
import 'contenedor_controller.dart';

//Cargamos en una lista de widgets los tabs pages
final _bodyContent = [
  const Perfil(),
  const Cumpleanios(),
  Configuracion(),
  Circulares(),
  Memorandums(),
  BoletinInformativo(),
  Container(),
  Container(),
];

class Contenedor extends StatelessWidget {
  Contenedor({super.key});

  final ContenedorController controller = Get.find<ContenedorController>();

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller = Get.find();
    return GetBuilder<CustomDrawerController>(
        id: "navbar",
        init: CustomDrawerController(),
        builder: (_) {
          return WillPopScope(
              onWillPop: () async {
                if (scaffoldKey.currentState!.isDrawerOpen) {
                  scaffoldKey.currentState!.openEndDrawer();
                  return false;
                }

                if (!kIsWeb) {
                  Get.generalDialog(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return AlertDialog(
                      title: const Text('¿Desea salir de la aplicación?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: const Text('Salir'),
                        ),
                      ],
                    );
                  });
                }
                return false;
              },
              child: Scaffold(
                  key: scaffoldKey,
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: appBarTitle(_.selectedIndex),
                    actions: [iconosActionAppBar(_.selectedIndex)],
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: MyPageView(
                            currentPage: _.selectedIndex,
                            children:
                                _bodyContent.map((item) => item).toList()),
                      ),
                    ],
                  )));
        });
  }

  appBarTitle(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const Text("Perfil");
      case 1:
        return const Text("Cumpleaños");
      case 2: // Otro
        return const Text("Configuración");
      case 3: // Otro
        return const Text("Circulares");
      case 4: // Otro
        return const Text("Memorandums");
      case 5: // Otro
        return const Text("Boletín Informativo");
      // case 8:
      // return const Text("Hacer un comentario");
      default:
        return const Text("Perfil");
    }
  }

  iconosActionAppBar(int selectedIndex) {
    switch (selectedIndex) {
      case 1:
        return IconButton(
          icon: const Icon(Icons.cake),
          onPressed: () {},
        );
      default:
        return Container();
    }
  }
}

class MyPageView extends StatefulWidget {
  final int currentPage;

  //Este List<Widget> children sera donde agregaremos nuestras tabs_pages
  final List<Widget> children;

  MyPageView({super.key, required this.currentPage, required this.children})
      // Le agregamos estas condiciones para que lance una excepcion si no se cumplen
      : assert(currentPage >= 0),
        assert(children.isNotEmpty && children.length >= 0);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final List<int> _rerenderdPage = [0];

  @override
  void didUpdateWidget(MyPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_rerenderdPage.contains(widget.currentPage)) {
      print('new page ${widget.currentPage}');

      setState(() {
        _rerenderdPage.add(widget.currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.currentPage,
      children: List.generate(
          widget.children.length,
          (index) => _rerenderdPage.contains(index)
              ? widget.children[index]
              : Container()),
    );
  }
}
