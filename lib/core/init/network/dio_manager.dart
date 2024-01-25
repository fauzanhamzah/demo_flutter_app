import 'package:dio/dio.dart';

class DioManager {
  static DioManager? _instance;

  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager._init();
    return _instance!;
  }

  final String _baseUrl = 'https://wsdl.maybankfinance.co.id:8282/api/';
  late final Dio dio;
  final Map<String, String> _headers = {
    "x-api-key": "ELa8oyoli4aE4QK6NEluGxoaMrmGxTenXEQSinBd"
  };

  DioManager._init() {
    dio = Dio(
      BaseOptions(baseUrl: _baseUrl, followRedirects: true, headers: _headers),
    );
  }
}
