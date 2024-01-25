import 'dart:io';

import 'package:demo_flutter_app/core/constants/enums/network_enums.dart';
import 'package:demo_flutter_app/core/data/model/auth_model.dart';
import 'package:demo_flutter_app/core/data/model/login_model.dart';
import 'package:demo_flutter_app/core/service/interface_auth_service.dart';

class AuthService extends IAuthService {
  AuthService(super.dioManager);

  @override
  Future<String?> login({
    required String userName,
    required String password,
  }) async {
    var response = await dioManager.dio.post(
      NetworkEnums.login.path,
      data: LoginModel(
        userName: userName,
        password: password,
      ).toJson(),
    );

    print(response);

    if (response.statusCode == HttpStatus.ok) {
      print(response.data);
      return AuthModel.fromJson(response.data).token;
    } else {
      return throw Exception();
    }
  }
}
