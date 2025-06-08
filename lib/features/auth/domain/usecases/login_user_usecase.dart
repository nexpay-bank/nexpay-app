import 'package:nexpay/features/auth/data/repositories/auth_repository.dart';

class LoginUserUsecase {
  final AuthRepository repository;

  LoginUserUsecase(this.repository);

  Future<void> call(String username, String password) {
    return repository.login(username, password);
  }
}
