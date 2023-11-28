part of 'signup_bloc.dart';

abstract class SignUpEvent {}

class onSignUpButtonPressed extends SignUpEvent {
  final SignUp signUp;
  onSignUpButtonPressed(this.signUp);
}
