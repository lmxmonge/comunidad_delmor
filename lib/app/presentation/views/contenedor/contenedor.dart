import 'package:comunidad_delmor/app/presentation/views/cumpleanios/cumpleanios.dart';
import 'package:comunidad_delmor/app/presentation/views/perfil/perfil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../global_widgets/custom_drawer_controller/custom_drawer.dart';
import '../../global_widgets/custom_drawer_controller/custom_drawer_controller.dart';

//Cargamos en una lista de widgets los tabs pages
final _bodyContent = [const Perfil(), const Cumpleanios()];

class Contenedor extends StatelessWidget {
  const Contenedor({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomDrawerController>(
        id: "navbar",
        init: CustomDrawerController(),
        builder: (_) {
          return Scaffold(
              drawer: const CustomDrawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.toNamed(Routes.other);
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: const Text('Comunidad Delmor'),
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: MyPageView(
                        currentPage: _.selectedIndex,
                        children: _bodyContent.map((item) => item).toList()),
                  ),
                ],
              ));
        });
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
