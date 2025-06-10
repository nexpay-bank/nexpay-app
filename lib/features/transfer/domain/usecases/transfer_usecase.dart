import 'package:nexpay/features/transfer/data/repositories/transfer_repository.dart';

class TransferUsecase {
  final TransferRepository repository;

  TransferUsecase(this.repository);

  Future<void> call({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
  }) {
    return repository.transfer(
      amount: amount,
      fromAccountId: fromAccountId,
      toAccountId: toAccountId,
    );
  }
}
