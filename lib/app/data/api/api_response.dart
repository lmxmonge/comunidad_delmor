import 'dart:convert';

class ApiResponse<T> {
  final String status;
  final String message;
  T? data;

  ApiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  // Factory para construir la clase desde un JSON
  factory ApiResponse.fromJson(String source) {
    try {
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

  // Métod para establecer los datos
  void setData(T data) {
    this.data = data;
  }

  @override
  String toString() {
    return 'ApiResponse(status: $status, message: $message, data: $data)';
  }
}
