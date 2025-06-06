import 'dart:async';

import 'package:dojo_challenges/src/di/provider/provider.dart';
import 'package:dojo_challenges/src/domain/data_base/auth_data_base_interface.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_scaffold.dart';
import 'package:dojo_challenges/src/presentation/widget/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_screen_test.mocks.dart';

@GenerateMocks([AuthDataBaseInterface])
void main() {
  late AuthDataBaseInterface mockAuthDataBase;
  late StreamController<User?> authStreamController;

  setUp(() {
    mockAuthDataBase = MockAuthDataBaseInterface();
    authStreamController = StreamController<User?>();
  });

  tearDown(() {
    authStreamController.close();
  });

  testWidgets('SplashScreen() should display the splash screen', (
    WidgetTester tester,
  ) async {
    //Given
    when(
      mockAuthDataBase.authStateChanges,
    ).thenAnswer((_) => authStreamController.stream);

    //When
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authDataBaseProvider.overrideWithValue(mockAuthDataBase)],
        child: MaterialApp(home: SplashScreen()),
      ),
    );

    //Then
    expect(find.byType(Image), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(MovieScaffold),
        matching: find.byType(Column),
      ),
      findsAtLeast(1),
    );
    expect(
      find.descendant(of: find.byType(Column), matching: find.byType(Image)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Column), matching: find.byType(SizedBox)),
      findsAtLeast(1),
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
