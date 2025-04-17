import 'package:flutter/material.dart';

class MovieScaffold extends StatelessWidget {
  const MovieScaffold({
    super.key,
    this.title,
    this.backgroundColor,
    required this.child,
  });
  final String? title;
  final Widget child;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null ? AppBar(title: Text(title!)) : null,
      backgroundColor: backgroundColor,
      body: SafeArea(child: child),
    );
  }
}
