import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/data/models/auth_token/auth_token.dart';
import 'package:nexpay/data/models/transaction/transaction.dart'; // sesuaikan path-nya

abstract class TransferRemoteDataSources {
  Future<void> transfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
  });
  Future<void> getTransfer();
}

class TransferRemoteDataSourcesImpl implements TransferRemoteDataSources {
  final Dio dio;
  final Isar isar;

  TransferRemoteDataSourcesImpl(this.dio, this.isar);

  @override
  Future<void> transfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
  }) async {
    try {
      final token = await isar.authTokens.where().findFirst();

      if (token == null) {
        throw Exception("Token not found. Please login first.");
      }

      final response = await dio.post(
        '/transactions/transfer',
        data: {
          'from_account_id': fromAccountId,
          'to_account_id': toAccountId,
          'amount': amount,
        },
        options: Options(headers: {'Authorization': 'Bearer ${token.token}'}),
      );

      if (response.statusCode != 200) {
        final errorMessage = response.data['error'] ?? 'Login failed';
        throw Exception(errorMessage);
      }

      final transactionResponse = await dio.get(
        '/transactions/history',
        options: Options(headers: {'Authorization': 'Bearer ${token.token}'}),
      );

      final transactions =
          transactionResponse.data['transactions'] as List<dynamic>;

      for (var i = 0; i < transactions.length; i++) {
        final trc = transactions[i] as Map<String, dynamic>;

        await isar.writeTxn(() async {
          if (i == 0) {
            await isar.transactions.clear();
          }
          await isar.transactions.put(
            Transaction()
              ..amount = double.parse(trc['amount'])
              ..accountId = trc['accountId']
              ..relatedAccountId = trc['relatedAccountId']
              ..type = trc['type']
              ..trcId = trc['trcId']
              ..timestamp = DateTime.parse(trc['timestamp']),
          );
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> getTransfer() async {
    try {
      final token = await isar.authTokens.where().findFirst();

      if (token == null) {
        throw Exception("Token not found. Please login first.");
      }

      final transactionResponse = await dio.get(
        '/transactions/history',
        options: Options(headers: {'Authorization': 'Bearer ${token.token}'}),
      );

      final transactions =
          transactionResponse.data['transactions'] as List<dynamic>;

      for (var i = 0; i < transactions.length; i++) {
        final trc = transactions[i] as Map<String, dynamic>;

        await isar.writeTxn(() async {
          if (i == 0) {
            await isar.transactions.clear();
          }
          await isar.transactions.put(
            Transaction()
              ..amount = double.parse(trc['amount'])
              ..accountId = trc['accountId']
              ..relatedAccountId = trc['relatedAccountId']
              ..type = trc['type']
              ..trcId = trc['trcId']
              ..timestamp = DateTime.parse(trc['timestamp']),
          );
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}
