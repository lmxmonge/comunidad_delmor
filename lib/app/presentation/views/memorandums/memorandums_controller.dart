import 'dart:async';
import 'dart:io';
import 'package:comunidad_delmor/app/data/models/memorandums_model.dart';
import 'package:comunidad_delmor/app/data/repositories/api_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/memorandums_model.dart';
import '../../routes/app_pages.dart';
import '../pdf/pdf_web_view.dart';

class MemorandumsController extends GetxController {
  final ApiRespository respository;

  MemorandumsController(this.respository);

  var isLoading = false.obs;

  RxList<MemorandumsModel> memorandums = <MemorandumsModel>[].obs;

  var remotePDFpath = "".obs;

  @override
  void onInit() {
    super.onInit();

    fetchMemorandums();
  }

  verPdf(MemorandumsModel model) {
    isLoading(true);
    try {
      Get.to(() => PdfWebView(
            url: model.url,
            title: model.nombre,
          ));
      isLoading(false);
      return;
    } catch (e) {
      dialogo('Error al procesar el archivo!', true, titulo: 'Error');
      isLoading(false);
    }
  }

  // Future<File> createFileOfPdfUrl(MemorandumsModel memorandum) async {
  //   remotePDFpath.value = "";
  //
  //   Completer<File> completer = Completer();
  //   print("Start download file from internet!");
  //   try {
  //     // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
  //     // final url = "https://pdfkit.org/docs/guide.pdf";
  //     // final url = "http://www.pdf995.com/samples/pdf.pdf";
  //     final url = memorandum.url;
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

  Future<void> fetchMemorandums() async {
    try {
      isLoading(true);
      memorandums.value = await respository.fetchMemorandums().then((value) {
        isLoading(false);
        return value;
      });

    } catch (e) {
      isLoading(false);
      var mensaje = e.toString().split(':').last.trim();
      dialogo(mensaje, true, titulo: 'Avertencia');
      print(e);
    }
  }

  void dialogo(String s, bool error, {required String titulo}) {
    Get.generalDialog(pageBuilder: (context, animation, secondaryAnimation) {
      return AlertDialog(
        icon: Icon(
          error ? Icons.error : Icons.check,
          color: error ? Colors.red : Colors.green,
          size: 48.0,
        ),
        title: Text(titulo),
        content: Text(s),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Aceptar'),
          )
        ],
      );
    });
  }
}
