import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexpay/data/models/user/user.dart';
import 'package:nexpay/features/home/data/datasources/user_remote_data_source.dart';
import 'package:nexpay/features/home/domain/usecases/update_photo_usecase.dart';
import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdatePhotoUseCase updatePhotoUseCase;
  final UserRemoteDataSource userRemoteDataSource;
  UserCubit(this.updatePhotoUseCase, this.userRemoteDataSource)
    : super(UserInitial());

  Future<void> updatePhoto(File file) async {
    try {
      emit(UserLoading());
      final url = await updatePhotoUseCase(file);
      final isar = GetIt.I<Isar>();
      final user = await isar.users.where().findFirst();

      if (user != null) {
        user.avatarUrl = url;
        await isar.writeTxn(() => isar.users.put(user));
        emit(UserSuccess(user));
      }
    } catch (e) {
      emit(UserFailure('Gagal update foto'));
    }
  }

  Future<void> logout() async {
    emit(UserLoading());
    try {
      await userRemoteDataSource.logout();
      emit(UserLogout());
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> delete() async {
    emit(UserLoading());
    try {
      await userRemoteDataSource.selfDelete();
      emit(UserLogout());
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> loadUser() async {
    final isar = GetIt.I<Isar>();
    final user = await isar.users.where().findFirst();
    if (user != null) emit(UserSuccess(user));
  }
}
