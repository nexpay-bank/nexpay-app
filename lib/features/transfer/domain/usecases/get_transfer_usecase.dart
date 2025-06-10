import 'package:nexpay/features/transfer/data/repositories/transfer_repository.dart';

class GetTransferUsecase {
  final TransferRepository repository;

  GetTransferUsecase(this.repository);

  Future<void> call() {
    return repository.getTransfer();
  }
}
