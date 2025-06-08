import 'package:nexpay/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:nexpay/features/auth/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<void> register(String username, String password) {
    return dataSource.register(username, password);
  }

  @override
  Future<void> login(String username, String password) {
    return dataSource.login(username, password);
  }
}
