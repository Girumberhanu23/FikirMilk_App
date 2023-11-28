import 'package:bloc/bloc.dart';
import 'package:fikir_milk/auth/signin/data/loginModel.dart';
import 'package:fikir_milk/auth/signin/data/loginRepo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<ForgotPassword>(_onForgotPassword);
    on<ResetPassword>(_onResetPassword);
  }

  void _onLoginButtonPressed(LoginButtonPressed event, Emitter emit) async {
    emit(LoginLoading());
    try {
      final isActive = await loginRepository.loginUser(event.login);
      emit(LoginSuccess(isActive));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  void _onForgotPassword(ForgotPassword event, Emitter emit) async {
    emit(ForgotPasswordLoading());
    try {
      await loginRepository.forgotPassword(event.email);
      if (event.isResentOtp) {
        emit(ResendOtpSuccess());
      } else {
        emit(ForgotPasswordSuccess());
      }
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  void _onResetPassword(ResetPassword event, Emitter emit) async {
    emit(ResetPasswordLoading());
    try {
      await loginRepository.resetPassword(event.id);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
