class UserModel {
  String username;
  String password;
  String codigoSap;
  String idUsuario;


  UserModel({
    required this.username,
    required this.password,
    required this.codigoSap,
    required this.idUsuario,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      password: json['token'],
      codigoSap: json['codigoSap'],
      idUsuario: json['idUsuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'token': password,
      'codigoSap': codigoSap,
      'idUsuario': idUsuario,
    };
  }
}
