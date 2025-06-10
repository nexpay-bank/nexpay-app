import 'dart:io';
import 'package:nexpay/features/home/data/repositories/user_repository.dart';

class UpdatePhotoUseCase {
  final UserRepository repo;

  UpdatePhotoUseCase(this.repo);

  Future<String> call(File file) {
    return repo.updatePhoto(file);
  }
}
