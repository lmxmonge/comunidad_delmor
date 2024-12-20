class ContraseniaModel {
  final String contrasenia;
  final String antiguaContrasenia;
  final String codigoSap;

  ContraseniaModel({
    required this.contrasenia,
    required this.antiguaContrasenia,
    this.codigoSap = '',
  });

  ContraseniaModel copyWith({
    String? contrasenia,
    String? antiguaContrasenia,
    String? codigoSap,

  }) {
    return ContraseniaModel(
      contrasenia: contrasenia ?? this.contrasenia,
      antiguaContrasenia: antiguaContrasenia ?? this.antiguaContrasenia,
      codigoSap: codigoSap ?? this.codigoSap,
    );
  }

  factory ContraseniaModel.fromJson(Map<String, dynamic> json) {
    return ContraseniaModel(
      contrasenia: json['password'],
      antiguaContrasenia: json['antiguaContrasenia'],
      codigoSap: json['codigoSAP'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': contrasenia,
      'antiguaContrasenia': antiguaContrasenia,
      'codigoSAP': codigoSap,
    };
  }
}
