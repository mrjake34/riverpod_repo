import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_repo/feature/authentication/login/view_model/login_view_model.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelProvider = ref.watch(loginViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              onChanged: (value) {
                if (value.isEmpty) return;
              },
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                ref
                    .read(loginViewModelProvider.notifier)
                    .login(email, password);
              },
              child: const Text('Login'),
            ),
            labelProvider.when(
              data: (data) =>
                  Text('Email: ${data.email} Password: ${data.password}'),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(loginViewModelProvider.notifier).logout();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
