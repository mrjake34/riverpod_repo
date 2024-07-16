import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_repo/feature/authentication/login/model/login_model.dart';

part 'login_view_model.g.dart';

@riverpod
final class LoginViewModel extends _$LoginViewModel {
  @override
  Future<LoginModel> build() async {
    return LoginModel(email: '', password: '');
  }

  void login(String email, String password) {
    state = AsyncData(LoginModel(email: email, password: password));
  }

  void logout() {
    state = const AsyncLoading();
    Future.delayed(const Duration(seconds: 2), () {
      state = AsyncData(LoginModel(email: '', password: ''));
    });
  }
}
