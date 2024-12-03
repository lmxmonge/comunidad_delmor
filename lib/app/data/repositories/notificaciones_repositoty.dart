import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constantes.dart';
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
    // required Function(RemoteMessage) onMessageOpenedApp,
  }) {
    _firebaseService.onMessage(onMessage);
    // _firebaseService.onMessageOpenedApp(onMessageOpenedApp);
  }

  Future<String> enviarToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final codigoSap = prefs.getString(Constantes.codigoSap) ?? '';
    final token = prefs.getString(Constantes.token) ?? '';
    late final String respuesta;

    try {
      respuesta = await _apiService.sendTokenToServer(token, codigoSap);
      print('$respuesta');
    } catch (e) {
      throw Exception(e);
    }
    return respuesta;
  }
}
