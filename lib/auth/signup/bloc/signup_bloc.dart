import 'package:bloc/bloc.dart';
import 'package:fikir_milk/auth/signup/data/signupRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikir_milk/auth/signup/data/signupModel.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpRepository signUpRepository;
  SignUpBloc(this.signUpRepository) : super(SignUpInitial()) {
    on<onSignUpButtonPressed>(_onSignUpButtonPressed);
  }

  void _onSignUpButtonPressed(onSignUpButtonPressed event, Emitter emit) async {
    emit(SignUpLoading());
    try {
      await signUpRepository.signUp(event.signUp);
      emit(SignUpSuccess());
    } catch (e) {
      print(e);
      emit(SignUpFailure(e.toString()));
    }
  }
}
