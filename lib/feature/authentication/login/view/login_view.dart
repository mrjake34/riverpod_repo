import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_repo/feature/authentication/login/view_model/address_view_model.dart';
import 'package:riverpod_repo/feature/authentication/login/view_model/login_view_model.dart';
import 'package:riverpod_repo/feature/home/view/home_page.dart';
import 'package:riverpod_repo/product/base/model/latlong.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ref.read(loginViewModelProvider.notifier).changeEmail(value);
              },
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                if (value.isEmpty) return;
                ref.read(loginViewModelProvider.notifier).changePassword(value);
              },
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                ref
                    .read(loginViewModelProvider.notifier)
                    .login(email, password);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text('Login'),
            ),
            Consumer(
              builder: (context, ref, child) {
                final labelProvider = ref.watch(loginViewModelProvider);
                return Column(
                  children: [
                    Text(labelProvider.email),
                    Text(labelProvider.password),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(loginViewModelProvider.notifier).logout();
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(addressViewModelProvider.notifier).getAddress(LatLong(
                    latitude: 41.02029580679229,
                    longitude: 28.661480450000003));
              },
              child: const Text('Get Address'),
            ),
            Consumer(
              builder: (context, ref, child) {
                final addressProvider = ref.watch(addressViewModelProvider);
                return addressProvider.when(
                  data: (data) => Text(data),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stackTrace) => Text('Error: $error'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
