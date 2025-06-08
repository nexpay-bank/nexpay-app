import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/data/models/auth_token.dart';
import 'package:nexpay/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:nexpay/shared/services/dio_service.dart';
import 'package:nexpay/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:nexpay/features/auth/data/repositories/auth_repository.dart';
import 'package:nexpay/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nexpay/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:nexpay/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nexpay/shared/services/isar/isar_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final isarService = IsarService();
  await isarService.init();

  // Isar
  sl.registerSingleton<IsarService>(isarService);
  sl.registerSingleton<Isar>(isarService.isar);

  // External
  sl.registerLazySingleton<Dio>(() => DioService.createDio());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<Dio>(), sl<Isar>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Usecase
  sl.registerLazySingleton(() => RegisterUserUsecase(sl()));
  sl.registerLazySingleton(() => LoginUserUsecase(sl()));

  // Cubit
  sl.registerFactory(() => AuthCubit(sl(), sl()));

  // Isar
}
