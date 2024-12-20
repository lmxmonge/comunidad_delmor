import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../utils/constantes.dart';
import '../../routes/app_pages.dart';
import 'package:universal_html/html.dart' as html;

class PdfWebView extends StatefulWidget {
  final String url;
  final String title;
  const PdfWebView({super.key, required this.url, required this.title});

  @override
  State<PdfWebView> createState() => _PdfWebViewState();
}

class _PdfWebViewState extends State<PdfWebView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController pdfController;

  double ancho = 0.2;
  @override
  void initState() {
    super.initState();
    pdfController = PdfViewerController();
    pdfController.zoomLevel = 1.0; // Zoom inicial

    print('URL: ${widget.url}');

    estaLogueado();
  }

  Future<void> estaLogueado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var estaLogueado = prefs.getBool(Constantes.user) ?? false;

    if (!estaLogueado) {
      prefs.clear();
      // Eliminar el token del dispositivo
      await FirebaseMessaging.instance.deleteToken();
      print('Token de FCM eliminado.');
      Get.back();
      Get.offAllNamed(Routes.splash);
    }
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? vistaWebPdf()
        : Scaffold(
      appBar: AppBar(
        title: const Text('Documento PDF'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              semanticLabel: 'Marcardores',
            ),
            onPressed: () {
              if (mounted) {
                _pdfViewerKey.currentState?.openBookmarkView();
              }
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.url,
        key: _pdfViewerKey,
      ),
    );
  }

  Widget vistaWebPdf() {
    if (MediaQuery.of(context).size.width >= 600) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Documento PDF'),

          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                semanticLabel: 'Marcardores',
              ),
              onPressed: () {
                if (mounted) {
                  _pdfViewerKey.currentState?.openBookmarkView();
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.zoom_in,
                semanticLabel: 'Zoom In',
              ),
              onPressed: () {
                // Incrementar el zoom
                pdfController.zoomLevel = pdfController.zoomLevel + 0.2;
                setState(() {

                  if(pdfController.zoomLevel > 1.2 && pdfController.zoomLevel < 2.0){
                    ancho = 0.0;
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.zoom_out,
                semanticLabel: 'Zoom Out',
              ),
              onPressed: () {
                // Reducir el zoom
                pdfController.zoomLevel = pdfController.zoomLevel - 0.2;

                setState(() {
                  if(pdfController.zoomLevel <= 1.0){
                    ancho = 0.2;
                  }
                });
              },
            ),
          ],
        ),
        body:
       Container(
         width: MediaQuery.of(context).size.width,
         color: Colors.grey[500],
         child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * ancho),
           child: Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(0.0),
             ),
             elevation: 5,
              child: SfPdfViewer.network(
                widget.url,
                key: _pdfViewerKey,
                controller: pdfController,
              ),
            ),
         ),
       ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documento PDF'),

        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              semanticLabel: 'Marcardores',
            ),
            onPressed: () {
              if (mounted) {
                _pdfViewerKey.currentState?.openBookmarkView();
              }
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.url,
        key: _pdfViewerKey,
      ),
    );
  }
}
