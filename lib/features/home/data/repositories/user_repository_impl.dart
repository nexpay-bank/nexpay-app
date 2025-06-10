import 'dart:io';
import 'package:nexpay/features/home/data/datasources/user_remote_data_source.dart';
import 'package:nexpay/features/home/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<String> updatePhoto(File file) {
    return remote.updatePhoto(file);
  }
}
