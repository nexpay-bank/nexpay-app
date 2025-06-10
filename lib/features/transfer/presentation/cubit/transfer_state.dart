part of 'transfer_cubit.dart';

@immutable
sealed class TransferState {}

final class TransferInitial extends TransferState {}

class TransferLoading extends TransferState {}

class TransferSuccess extends TransferState {
  final List<Transaction> transactions;
  TransferSuccess(this.transactions);
}

class TransferFailure extends TransferState {
  final String error;
  TransferFailure(this.error);
}
