class DatosLaboralesModel {
  final String nombres;
  final String fechaDeIngreso;
  final String cumpleanios;
  final String area;
  final String ocupcacion;
  final String aniosDeServicio;
  final String mesesDeServicio;
  final String vacacionesDisponibles;
  final String salario;
  final String edad;

  DatosLaboralesModel({
    required this.nombres,
    required this.fechaDeIngreso,
    required this.cumpleanios,
    required this.area,
    required this.ocupcacion,
    required this.aniosDeServicio,
    required this.mesesDeServicio,
    required this.vacacionesDisponibles,
    required this.salario,
    required this.edad,
  });

  factory DatosLaboralesModel.fromJson(Map<String, dynamic> json) {
    return DatosLaboralesModel(
      nombres: json['nombres'],
      fechaDeIngreso: json['startDate'],
      cumpleanios: json['birthDate'],
      area: json['descCentrBen'],
      ocupcacion: json['descCodOcup'],
      aniosDeServicio: json['anios'],
      mesesDeServicio: json['mesestrab'],
      vacacionesDisponibles: json['vacaciones'],
      salario: json['salario'],
      edad: json['edad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'startDate': fechaDeIngreso,
      'birthDate': cumpleanios,
      'descCentrBen': area,
      'descCodOcup': ocupcacion,
      'anios': aniosDeServicio,
      'mesestrab': mesesDeServicio,
      'vacaciones': vacacionesDisponibles,
      'salario': salario,
      'edad': edad,
    };
  }
}
