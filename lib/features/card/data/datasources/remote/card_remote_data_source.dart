import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/data/models/auth_token/auth_token.dart';
import 'package:nexpay/data/models/card/card.dart';

abstract class CardRemoteDataSource {
  Future<void> create();
  Future<void> get();
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final Dio dio;
  final Isar isar;

  CardRemoteDataSourceImpl(this.dio, this.isar);

  @override
  Future<void> create() async {
    final token = await isar.authTokens.where().findFirst();

    if (token == null) throw Exception('Token not found');

    final response = await dio.post(
      '/bank-accounts',
      data: {'initialBalance': 20},
      options: Options(headers: {'Authorization': 'Bearer ${token.token}'}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create bank account');
    }

    final data = response.data;

    final cardRes = await dio.get(
      '/bank-accounts',
      options: Options(headers: {'Authorization': 'Bearer ${token.token}'}),
    );
    final accounts = cardRes.data['accounts'] as List<dynamic>;

    for (var i = 0; i < accounts.length; i++) {
      final acc = accounts[i] as Map<String, dynamic>;

      await isar.writeTxn(() async {
        if (i == 0) {
          await isar.cards.clear();
        }
        await isar.cards.put(
          Card()
            ..balance = double.parse(acc['balance'].toString())
            ..accountId = acc['accountId'],
        );
      });
    }
  }

  @override
  Future<void> get() async {
    final token = await isar.authTokens.where().findFirst();

    if (token == null) throw Exception('Token not found');

    final response = await dio.get(
      '/bank-accounts',
      options: Options(headers: {'Authorization': 'Bearer ${token.token}'}),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create bank account');
    }
    final accounts = response.data['accounts'] as List<dynamic>;

    for (var i = 0; i < accounts.length; i++) {
      final acc = accounts[i] as Map<String, dynamic>;

      await isar.writeTxn(() async {
        if (i == 0) {
          await isar.cards.clear();
        }
        await isar.cards.put(
          Card()
            ..balance = double.parse(acc['balance'].toString())
            ..accountId = acc['accountId'],
        );
      });
    }
  }
}
