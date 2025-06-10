import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String username;
  late String avatarUrl;
}
