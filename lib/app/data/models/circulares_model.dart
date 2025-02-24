class CircularesModel {
  final String url;
  final String nombre;
  final String fechaEmision;

  CircularesModel({
    required this.url,
    required this.nombre,
    required this.fechaEmision,
  });

  factory CircularesModel.fromJson(Map<String, dynamic> json) {
    return CircularesModel(
      url: json['url'],
      nombre: json['pdf'],
      fechaEmision: json['fechaEmision'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'pdf': nombre,
      'fechaEmision': fechaEmision,
    };
  }
}
