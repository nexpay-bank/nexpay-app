import 'package:bloc/bloc.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/data/models/transaction/transaction.dart';
import 'package:nexpay/features/transfer/domain/usecases/get_transfer_usecase.dart';
import 'package:nexpay/features/transfer/domain/usecases/transfer_usecase.dart';
import 'package:meta/meta.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit(this.transferUsecase, this.isar, this.getTransferUsecase)
    : super(TransferInitial());
  final TransferUsecase transferUsecase;
  final GetTransferUsecase getTransferUsecase;
  final Isar isar;

  void transfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
  }) async {
    emit(TransferLoading());
    try {
      await transferUsecase(
        amount: amount,
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
      );
      final transactions = await isar.transactions.where().findAll();
      emit(TransferSuccess(transactions));
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }

  void getTransfer() async {
    emit(TransferLoading());
    try {
      await getTransferUsecase();
      final transactions = await isar.transactions.where().findAll();
      emit(TransferSuccess(transactions));
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }

  void resetState() {
    emit(TransferInitial());
  }
}
