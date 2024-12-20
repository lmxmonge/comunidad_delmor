class ActualizacionModel {
  String version;
  int codigoInterno;
  String url;

  ActualizacionModel({
    required this.version,
    required this.codigoInterno,
    required this.url,
  });

  factory ActualizacionModel.fromJson(Map<String, dynamic> json) {
    return ActualizacionModel(
      version: json['version'].toString(),
      codigoInterno: json['codigo_interno'] as int,
      url: json['url'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'codigo_interno': codigoInterno,
      'url': url,
    };
  }
}