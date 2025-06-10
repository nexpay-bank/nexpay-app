import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/data/models/auth_token/auth_token.dart'; // sesuaikan path-nya

abstract class AuthRemoteDataSource {
  Future<void> register(String username, String password);
  Future<void> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final Isar isar;

  AuthRemoteDataSourceImpl(this.dio, this.isar);

  @override
  Future<void> register(String username, String password) async {
    final response = await dio.post(
      '/users/register',
      data: {'username': username, 'password': password},
    );

    if (response.statusCode != 200) {
      throw Exception('Register failed');
    }
  }

  @override
  Future<void> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode != 200) {
        final errorMessage = response.data['error'] ?? 'Login failed';
        throw Exception(errorMessage);
      }

      final data = response.data;
      final token = data['token'];

      await isar.writeTxn(() async {
        await isar.authTokens.clear();
        await isar.authTokens.put(
          AuthToken()
            ..token = token
            ..username = username,
        );
      });
    } catch (e) {
      rethrow;
    }
  }
}
