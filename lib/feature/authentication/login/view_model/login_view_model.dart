import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_repo/feature/authentication/login/model/login_model.dart';

part 'login_view_model.g.dart';

@riverpod
final class LoginViewModel extends _$LoginViewModel {
  @override
  LoginModel build() {
    return LoginModel(email: '', password: '');
  }

  void changeEmail(String email) {
    state = state.copyWith(email: email);
  }

  void changePassword(String password) {
    state = state.copyWith(password: password);
  }

  void login(String email, String password) {
    state = LoginModel(email: email, password: password);
  }

  void logout() {
    state = LoginModel(email: '', password: '');
    Future.delayed(const Duration(seconds: 2), () {
      state = LoginModel(email: '', password: '');
    });
  }
}
