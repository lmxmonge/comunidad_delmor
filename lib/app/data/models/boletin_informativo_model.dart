class BoletinIformativoModel {
  final String url;
  final String nombre;
  final String fechaEmision;

  BoletinIformativoModel({
    required this.url,
    required this.nombre,
    required this.fechaEmision,
  });

  factory BoletinIformativoModel.fromJson(Map<String, dynamic> json) {
    return BoletinIformativoModel(
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
