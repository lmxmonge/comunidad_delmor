class DatosUsuarioModel {
  String cedula;
  String correo;
  String telefono;
  String inss;
  DatosUsuarioModel({
    required this.cedula,
    required this.correo,
    required this.telefono,
    required this.inss,

  });

  factory DatosUsuarioModel.fromJson(Map<String, dynamic> json) {
    return DatosUsuarioModel(
      cedula: json['govId'].toString(),
      correo: json['email'].toString(),
      telefono: json['mobile'].toString(),
      inss: json['inss'].toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'govId': cedula,
      'email': correo,
      'mobile': telefono,
      'inss': inss,
    };
  }
}
