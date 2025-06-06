import 'dart:async';

import 'package:dojo_challenges/src/core/util/asset_constants.dart';
import 'package:dojo_challenges/src/di/provider/provider.dart';
import 'package:dojo_challenges/src/domain/data_base/auth_data_base_interface.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_scaffold.dart';
import 'package:dojo_challenges/src/presentation/widget/unsuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unsuccess_test.mocks.dart';

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

  testWidgets('Unsuccess() should display the unsuccess', (
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
        child: MaterialApp(
          home: Unsuccess(text: 'text', image: AssetConstants.homePageEmpty),
        ),
      ),
    );

    //Then
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('text'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(MovieScaffold),
        matching: find.byType(Center),
      ),
      findsAtLeast(1),
    );
    expect(
      find.descendant(
        of: find.byType(Center),
        matching: find.byType(SingleChildScrollView),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Padding), matching: find.byType(Column)),
      findsOneWidget,
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
      find.descendant(of: find.byType(Column), matching: find.byType(Text)),
      findsAtLeast(1),
    );
  });
}
