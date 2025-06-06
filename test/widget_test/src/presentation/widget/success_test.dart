import 'dart:async';

import 'package:dojo_challenges/src/di/provider/provider.dart';
import 'package:dojo_challenges/src/domain/data_base/auth_data_base_interface.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_card.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_scaffold.dart';
import 'package:dojo_challenges/src/presentation/widget/success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_data/mock_data.dart';
import 'success_test.mocks.dart';

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

  testWidgets('Success() should display the success', (
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
        child: MaterialApp(home: Success(movies: [movieMock], callback: () {})),
      ),
    );

    //Then
    expect(
      find.descendant(
        of: find.byType(MovieScaffold),
        matching: find.byType(ListView),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(ListView),
        matching: find.byType(ListTile),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(ListTile),
        matching: find.byType(MovieCard),
      ),
      findsOneWidget,
    );
  });
}
