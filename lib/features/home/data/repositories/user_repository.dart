import 'dart:io';

abstract class UserRepository {
  Future<String> updatePhoto(File file);
}
