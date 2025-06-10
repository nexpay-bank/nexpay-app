import 'dart:io';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nexpay/data/models/auth_token/auth_token.dart';

class UserRemoteDataSource {
  final Dio dio;
  final Isar isar;

  UserRemoteDataSource(this.dio, this.isar);

  Future<String> updatePhoto(File file) async {
    final mimeType = lookupMimeType(file.path)?.split('/');
    if (file.lengthSync() > 2 * 1024 * 1024) {
      throw Exception("Ukuran gambar melebihi 2MB!");
    }

    final formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType(mimeType![0], mimeType[1]),
      ),
    });

    final response = await dio.post(
      '/users/photo',
      data: formData,
      options: Options(
        headers: {Headers.contentTypeHeader: 'multipart/form-data'},
      ),
    );
    return response.data['avatarUrl'];
  }

  Future<void> selfDelete() async {
    final token = await isar.authTokens.where().findFirst();

    if (token == null) throw Exception('Token not found');

    final responses = await dio.delete(
      '/users/self',
      options: Options(headers: {'Authorization': 'Bearer ${token.token}'}),
    );
    if (responses.statusCode != 200 && responses.statusCode != 201) {
      throw Exception('Failed to create bank account');
    }
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }

  Future<void> logout() async {
    final token = await isar.authTokens.where().findFirst();

    if (token == null) throw Exception('Token not found');

    final responses = await dio.post(
      '/logout',
      options: Options(headers: {'Authorization': 'Bearer ${token.token}'}),
    );
    if (responses.statusCode != 200) {
      throw Exception('Failed to logout');
    }
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }
}
