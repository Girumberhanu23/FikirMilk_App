import 'package:fikir_milk/auth/signin/data/loginDataSource.dart';
import 'package:fikir_milk/auth/signin/data/loginModel.dart';

class LoginRepository {
  LoginDataSource loginDataSource;
  LoginRepository(this.loginDataSource);
  Future<bool> loginUser(Login login) async {
    try {
      bool isActive = await loginDataSource.loginUser(login);
      return isActive;
    } catch (e) {
      throw e;
    }
  }

  Future forgotPassword(String email) async {
    try {
      await loginDataSource.forgotPassword(email);
    } catch (e) {
      throw e;
    }
  }

  Future resetPassword(String id) async {
    try {
      await loginDataSource.resetPassword(id);
    } catch (e) {
      throw e;
    }
  }
}
