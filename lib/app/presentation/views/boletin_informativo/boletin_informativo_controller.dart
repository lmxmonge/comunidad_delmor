import 'dart:async';
import 'dart:io';

import 'package:comunidad_delmor/app/data/models/boletin_informativo_model.dart';
import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:comunidad_delmor/app/presentation/global_widgets/custom_dialog/custom_dialog.dart';
import 'package:comunidad_delmor/app/presentation/views/pdf/pdf_web_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';

class BoletinInformativoController extends GetxController {
  final ApiRespository respository;

  BoletinInformativoController(this.respository);

  var isLoading = false.obs;
  var sinResultados = "".obs;

  RxList<BoletinIformativoModel> boletines = <BoletinIformativoModel>[].obs;

  var remotePDFpath = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchBoletines();
  }

  verPdf(BoletinIformativoModel model) {
    isLoading(true);
    try {
      Get.to(() => PdfWebView(
            url: model.url,
            title: model.nombre,
          ));
      isLoading(false);
      return;
    } catch (e) {
      CustomDialog.dialogo('Error al procesar el archivo!', true,
          titulo: 'Error');
      isLoading(false);
    }
  }

  //
  // Future<File> createFileOfPdfUrl(BoletinIformativoModel boletin) async {
  //   remotePDFpath.value = "";
  //
  //   Completer<File> completer = Completer();
  //   print("Start download file from internet!");
  //   try {
  //     // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
  //     // final url = "https://pdfkit.org/docs/guide.pdf";
  //     // final url = "http://www.pdf995.com/samples/pdf.pdf";
  //     final url = boletin.url;
  //
  //     final filename = url.substring(url.lastIndexOf("/") + 1);
  //     var request = await HttpClient().getUrl(Uri.parse(url));
  //     var response = await request.close();
  //     var bytes = await consolidateHttpClientResponseBytes(response);
  //     var dir = await getApplicationDocumentsDirectory();
  //     print("Download files");
  //     print("${dir.path}/$filename");
  //     File file = File("${dir.path}/$filename");
  //
  //     await file.writeAsBytes(bytes, flush: true);
  //     completer.complete(file);
  //   } catch (e) {
  //     print("entro1: ");
  //     throw Exception('Error al procesar el archivo!');
  //   }
  //
  //   return completer.future;
  // }

  Future<void> fetchBoletines() async {
    try {
      isLoading(true);
      var value = await respository.fetchBoletinesInformativos();

      if (value.data is List<BoletinIformativoModel>) {
        boletines.value = value.data;
      } else {
        sinResultados.value = value.message;
        boletines.value = [];
      }
    } catch (e) {
      print(e);
      var mensaje = e.toString().split(':').last.trim();

      if (mensaje.contains("Verifique su conexión de internet")) {
        CustomDialog.dialogoSinConexionAInternet(
            mensaje: mensaje, titulo: "Advertencia");
      } else {
       CustomDialog.dialogo(mensaje, true, titulo: 'Advertencia');
      }
    } finally {
      isLoading(false);
    }
  }

  void iniciarPdf() {}

}
