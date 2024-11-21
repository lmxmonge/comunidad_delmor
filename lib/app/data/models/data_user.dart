class DataUser {
  String empid;
  String nombres;
  String govId;
  String correo;
  String fechaInicioEmpresa;
  String cumpleanios;
  String inss;
  String salario;
  String descCentrBen;
  String descCargo;

  DataUser({
    required this.empid,
    required this.nombres,
    required this.govId,
    required this.correo,
    required this.fechaInicioEmpresa,
    required this.cumpleanios,
    required this.inss,
    required this.salario,
    required this.descCentrBen,
    required this.descCargo,
  });

  //from json to json
  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      empid: json['empid'],
      nombres: json['nombres'],
      govId: json['govId'],
      correo: json['correo'],
      fechaInicioEmpresa: json['fechaInicioEmpresa'],
      cumpleanios: json['cumpleanios'],
      inss: json['inss'],
      salario: json['salario'],
      descCentrBen: json['descCentrBen'],
      descCargo: json['descCargo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'empid': empid,
      'nombres': nombres,
      'govId': govId,
      'correo': correo,
      'fechaInicioEmpresa': fechaInicioEmpresa,
      'cumpleanios': cumpleanios,
      'inss': inss,
      'salario': salario,
      'descCentrBen': descCentrBen,
      'descCargo': descCargo,
    };
  }
}
