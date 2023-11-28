import 'package:fikir_milk/auth/signup/data/signupDataSource.dart';
import 'package:fikir_milk/auth/signup/data/signupModel.dart';

class SignUpRepository {
  SignUpDataSource signUpDataSource;
  SignUpRepository(this.signUpDataSource);
  Future signUp(SignUp signUpUser) async {
    try {
      await signUpDataSource.signUp(signUpUser);
    } catch (e) {
      throw e;
    }
  }
}
