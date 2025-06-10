import 'package:isar/isar.dart';

part 'transaction.g.dart';

@collection
class Transaction {
  Id id = Isar.autoIncrement;
  late int trcId;
  late int accountId;
  late int relatedAccountId;
  late String type;
  late double amount;
  late DateTime timestamp;
}
