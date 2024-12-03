import 'package:comunidad_delmor/utils/constantes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/api_repository.dart';

class FirebaseService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Inicializar Firebase y FCM
  Future<void> initialize() async {
    await Firebase.initializeApp();

    await _messaging.setAutoInitEnabled(true);
    await FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);

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

    // Obtener y mostrar el token FCM
    String? token = await _messaging.getToken();
    print('Token FCM: $token');

    //guardar el token en preferencias
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constantes.token, token!);

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

  // Mostrar notificación en segundo plano
@pragma('vm:entry-point')
static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Mensaje en segundo plano: ${message.notification?.title}');
  // Create a new instance of FirebaseService to call the instance method
  FirebaseService service = FirebaseService();
  await service._showNotification(message); // Mostrar la notificación

  // Si necesitas hacer algo más, puedes agregarlo aquí
}

  // Mostrar notificación con flutter_local_notifications
  Future<void> _showNotification(RemoteMessage message) async {
    var androidDetails = AndroidNotificationDetails(
      'your_channel_id', // Canal de notificaciones
      'your_channel_name',
      channelDescription: 'Descripción de tu canal',
      importance: Importance.max,
      priority: Priority.high,
    );
    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: 'item x', // Puedes pasar datos extras si lo necesitas
    );
  }
}
