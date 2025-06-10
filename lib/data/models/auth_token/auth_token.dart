import 'package:isar/isar.dart';

part 'auth_token.g.dart';

@collection
class AuthToken {
  Id id = Isar.autoIncrement;
  late String username;
  late String token;
}
