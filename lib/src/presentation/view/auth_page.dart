import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/util/number_constants.dart';
import '../../core/util/route_constants.dart';
import '../../core/util/string_constants.dart';
import '../../di/provider/provider.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = true;
  late final StreamSubscription<User?> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = ref.read(authDataBaseProvider).authStateChanges.listen((
      user,
    ) {
      if (user != null && mounted) {
        Navigator.of(context).pushReplacementNamed(RouteConstants.homeRoute);
      }
    });
  }

  Future<void> _handleAuth() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final authController = ref.read(authControllerProvider);

    try {
      if (isLogin) {
        await authController.signInWithEmailAndPassword(email, password);
      } else {
        await authController.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${StringConstants.authPageErrorText}${e.toString()}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLogin
              ? StringConstants.authPageLoginText
              : StringConstants.authPageRegisterText,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(NumberConstants.authPagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: StringConstants.authPageEmailText,
              ),
            ),
            SizedBox(height: NumberConstants.authPageTopSizedBoxHeight),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: StringConstants.authPagePasswordText,
              ),
              obscureText: true,
            ),
            SizedBox(height: NumberConstants.authPageCenterSizedBoxHeight),
            ElevatedButton(
              onPressed: _handleAuth,
              child: Text(
                isLogin
                    ? StringConstants.authPageLoginText
                    : StringConstants.authPageRegisterText,
              ),
            ),
            SizedBox(height: NumberConstants.authPageBottomSizedBoxHeight),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(
                isLogin
                    ? StringConstants.authPageCreateAccountText
                    : StringConstants.authPageHaveAnAccountLoginText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
