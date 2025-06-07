import 'package:nexpay/shared/services/isar/user_model.dart';
import 'package:isar/isar.dart';
// import 'package:nexpay/shared/services/isar/user_model.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:nexpay/features/user/data/models/user_model.dart';
class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([UserSchema], directory: dir.path);
  }
}
