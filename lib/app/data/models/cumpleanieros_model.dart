class Cumpleanieros {
  final String nombres;
  final String fechaDeIngreso;
  final String area;
  final String aniosDeServicio;
  final String mesesDeServicio;
  final String cumpleanios;

  Cumpleanieros({
    required this.nombres,
    required this.fechaDeIngreso,
    required this.area,
    required this.aniosDeServicio,
    required this.mesesDeServicio,
    required this.cumpleanios,
  });

  factory Cumpleanieros.fromJson(Map<String, dynamic> json) {
    return Cumpleanieros(
      nombres: json['nombres'],
      fechaDeIngreso: json['startDate'],
      area: json['descCentrBen'],
      aniosDeServicio: json['anios'],
      mesesDeServicio: json['mesestrab'],
      cumpleanios: json['birthDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'startDate': fechaDeIngreso,
      'descCentrBen': area,
      'anios': aniosDeServicio,
      'mesestrab': mesesDeServicio,
      'birthDate': cumpleanios,
    };
  }
}
