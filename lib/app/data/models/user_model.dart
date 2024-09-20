class UserModel {
  String username;
  String password;

  UserModel({
    required this.username,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      password: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'token': password,
    };
  }
}
