part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final Login login;
  LoginButtonPressed(this.login);
}

class ForgotPassword extends LoginEvent {
  final String email;
  final bool isResentOtp;
  ForgotPassword(this.email, this.isResentOtp);
}

class ResetPassword extends LoginEvent {
  final String id;
  ResetPassword(this.id);
}
