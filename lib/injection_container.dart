import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:nexpay/features/card/data/datasources/remote/card_remote_data_source.dart';
import 'package:nexpay/features/card/data/repositories/card_repository.dart';
import 'package:nexpay/features/card/data/repositories/card_repository_impl.dart';
import 'package:nexpay/features/card/domain/usecases/create_card_use_case.dart';
import 'package:nexpay/features/card/domain/usecases/get_card_use_case.dart';
import 'package:nexpay/features/card/presentation/cubit/card_cubit.dart';
import 'package:nexpay/features/home/data/datasources/user_remote_data_source.dart';
import 'package:nexpay/features/home/data/repositories/user_repository.dart';
import 'package:nexpay/features/home/data/repositories/user_repository_impl.dart';
import 'package:nexpay/features/home/domain/usecases/update_photo_usecase.dart';
import 'package:nexpay/features/home/presentation/cubit/user_cubit.dart';
import 'package:nexpay/features/transfer/data/datasources/remote/transfer_remote_data_sources.dart';
import 'package:nexpay/features/transfer/data/repositories/transfer_repository.dart';
import 'package:nexpay/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:nexpay/features/transfer/domain/usecases/get_transfer_usecase.dart';
import 'package:nexpay/features/transfer/domain/usecases/transfer_usecase.dart';
import 'package:nexpay/features/transfer/presentation/cubit/transfer_cubit.dart';
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
  sl.registerLazySingleton<CardRemoteDataSource>(
    () => CardRemoteDataSourceImpl(sl<Dio>(), sl<Isar>()),
  );
  sl.registerLazySingleton<TransferRemoteDataSources>(
    () => TransferRemoteDataSourcesImpl(sl<Dio>(), sl<Isar>()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(sl<Dio>(), sl<Isar>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<CardRepository>(() => CardRepositoryImpl(sl()));
  sl.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  // Usecase
  sl.registerLazySingleton(() => RegisterUserUsecase(sl()));
  sl.registerLazySingleton(() => LoginUserUsecase(sl()));
  sl.registerLazySingleton(() => CreateCardUseCase(sl()));
  sl.registerLazySingleton(() => GetCardUseCase(sl()));
  sl.registerLazySingleton(() => TransferUsecase(sl()));
  sl.registerLazySingleton(() => GetTransferUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePhotoUseCase(sl()));

  // Cubit
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerFactory(() => CardCubit(sl(), sl(), sl()));
  sl.registerFactory(() => TransferCubit(sl(), sl(), sl()));
  sl.registerFactory(() => UserCubit(sl(), sl()));
}
