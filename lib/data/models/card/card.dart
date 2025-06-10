import 'package:isar/isar.dart';

part 'card.g.dart';

@collection
class Card {
  Id id = Isar.autoIncrement;

  late int accountId;
  late double balance;
}
