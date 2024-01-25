import 'package:demo_flutter_app/core/init/network/dio_manager.dart';

abstract class IAuthService {
  final DioManager dioManager;

  IAuthService(this.dioManager);

  Future<String?> login({
    required String userName,
    required String password,
  });
}
