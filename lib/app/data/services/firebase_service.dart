import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../repositories/api_repository.dart';

class FirebaseService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Inicializar Firebase y FCM
  Future<void> initialize() async {
    await Firebase.initializeApp();

    await _messaging.setAutoInitEnabled(true);

    if (!kIsWeb) {
      await FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
    }

    print('Notificaciones inicializadddads');

    // Inicializar las notificaciones locales
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Configurar el handler para mensajes en segundo plano
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    // Solicitar permisos de notificación
    await _requestPermission();

    await guardarTokenEnPreferencias();
  }

  // Solicitar permisos de notificaciones
  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permisos de notificación concedidos.');
    } else {
      print('Permisos de notificación denegados.');
    }
  }

  // Mostrar notificación cuando el app está en primer plano
  void onMessage(Function(RemoteMessage) callback) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Mensaje recibido: ${message.notification?.title}');

      // Mostrar la notificación con flutter_local_notifications
      await _showNotification(message);

      callback(message);
    });
  }

  void onMessageOpenedApp(Function(RemoteMessage) callback) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Mensaje recibido al abrir la app: ${message.notification?.title}');

      // Mostrar la notificación con flutter_local_notifications
      // await _showNotification(message);
      Future.delayed(const Duration(seconds: 4), () {
        scaffoldKey.currentState?.openDrawer();
        print('Abriendo el drawer');
      });
      callback(message);
    });
  }

  // Mostrar notificación en segundo plano
  @pragma('vm:entry-point')
  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Mensaje en segundo plano: ${message.notification?.title}');
    // Create a new instance of FirebaseService to call the instance method
    FirebaseService service = FirebaseService();

    await service._showNotification(message); // Mostrar la notificación

    // Si necesitas hacer algo más, puedes agregarlo aquí

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (message.data['type']) {
      case 'memoramdums':
        await prefs.setInt(Constantes.memoramdums,
            (prefs.getInt(Constantes.memoramdums) ?? 0) + 1);
        break;
      case 'boletines':
        await prefs.setInt(Constantes.boletines,
            (prefs.getInt(Constantes.boletines) ?? 0) + 1);
        break;
      case 'circulares':
        await prefs.setInt(Constantes.circulares,
            (prefs.getInt(Constantes.circulares) ?? 0) + 1);

        break;
      default:
    }
  }

  // Mostrar notificación con flutter_local_notifications
  Future<void> _showNotification(RemoteMessage message) async {
    if (!kIsWeb) {
      // var androidInitializationSettings =
      //     AndroidInitializationSettings('@mipmap/ic_launcher');
      //
      // await flutterLocalNotificationsPlugin.initialize(
      //   InitializationSettings(android: androidInitializationSettings),
      //   onDidReceiveNotificationResponse: (details) {
      //     Future.delayed(const Duration(seconds: 4), () {
      //       scaffoldKey.currentState?.openDrawer();
      //       print('Abriendo el drawer');
      //     });
      //   },
      // );

      var androidDetails = const AndroidNotificationDetails(
        'your_channel_id', // Canal de notificaciones
        'your_channel_name',
        channelDescription: 'Descripción de tu canal',
        importance: Importance.max,
        priority: Priority.high,
      );
      var notificationDetails = NotificationDetails(android: androidDetails);

      print("Entro en web");
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: 'item x', // Puedes pasar datos extras si lo necesitas
      );
      return;
    }

    showSimpleNotification(
      title: message.notification?.title ?? 'Sin título',
      body: message.notification?.body ?? 'Sin cuerpo',
      payload: 'item x',
    );
  }

  Future guardarTokenEnPreferencias({int maxRetires = 3}) async {
    try {
      // Obtener y mostrar el token FCM
      String? token;
      if (kIsWeb) {
        token = await _messaging.getToken(
            vapidKey:
                "BH64kfyxV8GcVYLPuNBzBktunp0Mwfpf_UmLPfsZkD01flG8_UjMR_5NPNlpNBP1OuVGLryY9Gl98ebJG4W7eH8");
        print('Web Token FCM: $token');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constantes.tokenWeb, token!);

        return;
      }

      token = await _messaging.getToken();
      print('Android Token FCM: $token');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constantes.tokenAndroid, token!);
    } catch (e) {
      print("failed to get device token");
      if (maxRetires > 0) {
        print("try after 10 sec");
        await Future.delayed(Duration(seconds: 10));
        return guardarTokenEnPreferencias(maxRetires: maxRetires - 1);
      } else {
        return null;
      }
    }
  }

  void showSimpleNotification({
    required String title,
    required String body,
    NotificationDetails? notificationDetails,
    required String payload,
  }) {
    if (Get.context == null) {
      print('Error: Contexto no disponible');
      return;
    }
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Aceptar'),
              ),
            ],
          );
        });
  }
}
