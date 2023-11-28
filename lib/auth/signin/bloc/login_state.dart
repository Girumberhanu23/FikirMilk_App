part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final bool isActive;
  LoginSuccess(this.isActive);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class LoginLoading extends LoginState {}

class ForgotPasswordSuccess extends LoginState {}

class ResendOtpSuccess extends LoginState {}

class ForgotPasswordFailure extends LoginState {
  final String error;
  ForgotPasswordFailure(this.error);
}

class ForgotPasswordLoading extends LoginState {}

class ResetPasswordSuccess extends LoginState {}

class ResetPasswordFailure extends LoginState {
  final String error;
  ResetPasswordFailure(this.error);
}

class ResetPasswordLoading extends LoginState {}
