import 'dart:convert';

class ApiResponse {
  final String status;
  final String message;

  // Constructor principal
  ApiResponse({required this.status, required this.message});

  // Factory para construir la clase desde un JSON
  factory ApiResponse.fromJson(String source) {
    try {

      // Decodificar el JSON
      final Map<String, dynamic> json = jsonDecode(source);

      // Validar si contiene las claves necesarias
      if (json.containsKey('status') && json.containsKey('message')) {

        return ApiResponse(
          status: json['status'] as String,
          message: json['message'] as String,
        );
      } else {
        throw FormatException("El JSON no contiene las claves esperadas.");
      }
    } on Exception catch (e) {
      throw FormatException("Error al procesar el JSON: $e");
    }
  }

  @override
  String toString() {
    return 'ApiResponse(status: $status, message: $message)';
  }
}
