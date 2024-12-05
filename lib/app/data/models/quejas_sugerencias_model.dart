class QuejasSugerenciasModel {
  String tipo;
  String comentario;
  String fecha;

  QuejasSugerenciasModel({
    required this.tipo,
    required this.comentario,
    required this.fecha,
  });

  factory QuejasSugerenciasModel.fromJson(Map<String, dynamic> json) {
    return QuejasSugerenciasModel(
      tipo: json['tipo'],
      comentario: json['comentario'],
      fecha: json['fecha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'comentario': comentario,
      'fecha': fecha,
    };
  }
}
