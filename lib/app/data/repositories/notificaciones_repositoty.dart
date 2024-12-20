import 'package:firebase_messaging/firebase_messaging.dart';
import '../services/api_service.dart';
import '../services/firebase_service.dart';

class NotificacionesRepository {

  final ApiServiceImpl _apiService;

  final FirebaseService _firebaseService;

  NotificacionesRepository(this._firebaseService, this._apiService);

  Future<void> initialize() async {
    await _firebaseService.initialize();
  }

  void listenToMessages({
    required Function(RemoteMessage) onMessage,
    required Function(RemoteMessage) onMessageOpenedApp,
  }) {
    _firebaseService.onMessage(onMessage);
    // _firebaseService.onMessageBackground(onMessageBackground);

    _firebaseService.onMessageOpenedApp((RemoteMessage message) {
       // print('A new onMessageOpenedApp event was published!');
    });
  }

  Future<String> enviarToken() async {
    late final String respuesta;

    try {
      respuesta = await _apiService.sendTokenToServer();
      print('respuesta enviarToken: $respuesta');
    } catch (e) {
      throw Exception(e);
    }
    return respuesta;
  }
}
