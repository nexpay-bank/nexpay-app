import 'package:nexpay/features/transfer/data/datasources/remote/transfer_remote_data_sources.dart';
import 'package:nexpay/features/transfer/data/repositories/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDataSources dataSource;

  TransferRepositoryImpl(this.dataSource);

  @override
  Future<void> transfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
  }) {
    return dataSource.transfer(
      fromAccountId: fromAccountId,
      toAccountId: toAccountId,
      amount: amount,
    );
  }

  @override
  Future<void> getTransfer() {
    return dataSource.getTransfer();
  }
}
