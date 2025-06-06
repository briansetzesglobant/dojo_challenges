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

class MovieScaffold extends ConsumerStatefulWidget {
  const MovieScaffold({
    super.key,
    this.title,
    this.backgroundColor,
    this.callBack,
    required this.child,
  });

  final String? title;
  final Color? backgroundColor;
  final VoidCallback? callBack;
  final Widget child;

  @override
  ConsumerState<MovieScaffold> createState() => _MovieScaffoldState();
}

class _MovieScaffoldState extends ConsumerState<MovieScaffold> {
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
      if (user == null && mounted) {
        Navigator.of(context).pushReplacementNamed(RouteConstants.authRoute);
      }
    });
  }

  Future<void> _handleSignOut() async {
    final auth = ref.read(authControllerProvider);
    try {
      await auth.signOut();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${StringConstants.movieScaffoldErrorText}${e.toString()}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateChangesProvider).asData?.value;
    return Scaffold(
      appBar: widget.title != null ? AppBar(title: Text(widget.title!)) : null,
      backgroundColor: widget.backgroundColor,
      body: SafeArea(child: widget.child),
      floatingActionButton: IconButton(
        icon: Icon(Icons.logout),
        onPressed: _handleSignOut,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.callBack != null)
            Padding(
              padding: const EdgeInsets.all(
                NumberConstants.movieScaffoldButtonPadding,
              ),
              child: ElevatedButton(
                onPressed: widget.callBack,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.appThemeColor,
                ),
                child: const Text(
                  StringConstants.movieScaffoldButtonText,
                  style: TextStyleConstants.movieScaffoldButtonTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            SizedBox(height: NumberConstants.movieScaffoldSizedBoxHeight),
          Text('${StringConstants.movieScaffoldWelcomeText}${user?.email}'),
          SizedBox(height: NumberConstants.movieScaffoldSizedBoxHeight),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
