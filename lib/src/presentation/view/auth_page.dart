import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/util/color_constants.dart';
import '../../core/util/number_constants.dart';
import '../../core/util/route_constants.dart';
import '../../core/util/string_constants.dart';
import '../../core/util/text_style_constants.dart';
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
              '${StringConstants.authPageSnackBarErrorText}${e.toString()}',
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
              ? StringConstants.authPageLoginButtonText
              : StringConstants.authPageRegisterButtonText,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(NumberConstants.authPagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              cursorColor: ColorConstants.appThemeColor,
              controller: emailController,
              decoration: InputDecoration(
                labelText: StringConstants.authPageEmailTextFieldText,
                labelStyle: TextStyleConstants.generaTextStyle,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.appThemeColor),
                ),
              ),
            ),
            SizedBox(height: NumberConstants.authPageTopSizedBoxHeight),
            TextField(
              cursorColor: ColorConstants.appThemeColor,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: StringConstants.authPagePasswordTextFieldText,
                labelStyle: TextStyleConstants.generaTextStyle,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.appThemeColor),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: NumberConstants.authPageCenterSizedBoxHeight),
            ElevatedButton(
              onPressed: _handleAuth,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.appThemeColor,
              ),
              child: Text(
                isLogin
                    ? StringConstants.authPageLoginButtonText
                    : StringConstants.authPageRegisterButtonText,
                style: TextStyleConstants.generaTextStyle,
              ),
            ),
            SizedBox(height: NumberConstants.authPageBottomSizedBoxHeight),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(
                isLogin
                    ? StringConstants.authPageCreateAccountButtonText
                    : StringConstants.authPageHaveAnAccountLoginButtonText,
                style: TextStyleConstants.generaTextStyle,
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
