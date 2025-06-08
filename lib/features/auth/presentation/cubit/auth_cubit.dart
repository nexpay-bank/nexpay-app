import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nexpay/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:nexpay/features/auth/domain/usecases/register_user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUserUsecase registerUsecase;
  final LoginUserUsecase loginUserUsecase;

  AuthCubit(this.registerUsecase, this.loginUserUsecase) : super(AuthInitial());

  void register({required String username, required String password}) async {
    emit(AuthLoading());
    try {
      await registerUsecase(username, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void login({required String username, required String password}) async {
    emit(AuthLoading());
    try {
      await loginUserUsecase(username, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
