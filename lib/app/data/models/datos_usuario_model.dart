class DatosUsuarioModel {
  String cedula;
  String correo;
  String telefono;
  String inss;

  String nombres;
  String usuarioSap;
  String fechaInicioEmpresa;
  String cumpleanios;
  String salario;
  String area;
  String cargoArea;

  DatosUsuarioModel({
    required this.cedula,
    required this.correo,
    required this.telefono,
    required this.inss,
    required this.nombres,
    required this.usuarioSap,
    required this.fechaInicioEmpresa,
    required this.cumpleanios,
    required this.salario,
    required this.area,
    required this.cargoArea,
  });

  factory DatosUsuarioModel.fromJson(Map<String, dynamic> json) {
    return DatosUsuarioModel(
      cedula: json['govId'].toString(),
      correo: json['email'].toString(),
      telefono: json['mobile'].toString(),
      inss: json['inss'].toString() ?? '',
      nombres: json['nombres'].toString(),
      usuarioSap: json['empid'].toString(),
      fechaInicioEmpresa: json['startDate'].toString(),
      cumpleanios: json['birthDate'].toString(),
      salario: json['salary'].toString(),
      area: json['descCentrBen'].toString(),
      cargoArea: json['descCargo'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'govId': cedula,
      'email': correo,
      'mobile': telefono,
      'inss': inss,
      'nombres': nombres,
      'empid': usuarioSap,
      'startDate': fechaInicioEmpresa,
      'birthDate': cumpleanios,
      'salary': salario,
      'descCentrBen': area,
      'descCargo': cargoArea,
    };
  }
}
