abstract class TransferRepository {
  Future<void> transfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
  });
  Future<void> getTransfer();
}
