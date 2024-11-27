class MemorandumsModel {
  final String url;
  final String nombre;
  final String fechaEmision;

  MemorandumsModel({
    required this.url,
    required this.nombre,
    required this.fechaEmision,
  });

  factory MemorandumsModel.fromJson(Map<String, dynamic> json) {
    return MemorandumsModel(
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
