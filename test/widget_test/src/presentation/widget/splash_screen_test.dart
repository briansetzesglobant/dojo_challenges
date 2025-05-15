import 'package:dojo_challenges/src/presentation/widget/movie_scaffold.dart';
import 'package:dojo_challenges/src/presentation/widget/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplashScreen() should display the splash screen', (
    WidgetTester tester,
  ) async {
    //Given

    //When
    await tester.pumpWidget(MaterialApp(home: SplashScreen()));

    //Then
    expect(find.byType(Image), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(MovieScaffold),
        matching: find.byType(Column),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Column), matching: find.byType(Image)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Column), matching: find.byType(SizedBox)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Column), matching: find.byType(Center)),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(Center),
        matching: find.byType(CircularProgressIndicator),
      ),
      findsOneWidget,
    );
  });
}
