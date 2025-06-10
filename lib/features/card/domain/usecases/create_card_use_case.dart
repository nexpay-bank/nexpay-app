import 'package:nexpay/features/card/data/repositories/card_repository.dart';

class CreateCardUseCase {
  final CardRepository repository;

  CreateCardUseCase(this.repository);

  Future<void> call() {
    return repository.create();
  }
}
