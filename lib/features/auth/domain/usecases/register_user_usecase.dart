import 'package:nexpay/features/auth/data/repositories/auth_repository.dart';

class RegisterUserUsecase {
  final AuthRepository repository;

  RegisterUserUsecase(this.repository);

  Future<void> call(String username, String password) {
    return repository.register(username, password);
  }
}
