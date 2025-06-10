// shared/services/dio_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioService {
  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? '',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        validateStatus: (status) => status! < 500,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'x-api-key': dotenv.env['API_KEY'] ?? '',
        },
      ),
    )..interceptors.add(LogInterceptor(responseBody: true));
  }
}
