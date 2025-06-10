import 'package:nexpay/features/card/data/repositories/card_repository.dart';

class GetCardUseCase {
  final CardRepository repository;

  GetCardUseCase(this.repository);

  Future<void> call() {
    return repository.get();
  }
}
