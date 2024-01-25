class AuthModel {
  String? token;

  AuthModel({this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['Token'] as String?,
    );
  }
}
