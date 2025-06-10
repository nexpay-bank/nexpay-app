import 'package:isar/isar.dart';
import 'package:nexpay/data/models/auth_token/auth_token.dart';
import 'package:nexpay/data/models/card/card.dart';
import 'package:nexpay/data/models/transaction/transaction.dart';
import 'package:nexpay/data/models/user/user.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late final Isar _isar;

  Isar get isar => _isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      AuthTokenSchema,
      CardSchema,
      TransactionSchema,
      UserSchema,
    ], directory: dir.path);
  }

  Future<bool> isLoggedIn() async {
    final user = await _isar.authTokens.where().findFirst();
    return user?.token != null;
  }
}
