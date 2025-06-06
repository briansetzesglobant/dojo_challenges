import 'dart:async';

import 'package:dojo_challenges/src/core/util/string_constants.dart';
import 'package:dojo_challenges/src/di/provider/provider.dart';
import 'package:dojo_challenges/src/domain/data_base/auth_data_base_interface.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_scaffold_test.mocks.dart';

@GenerateMocks([AuthDataBaseInterface])
void main() {
  group('MovieScaffold test', () {
    late AuthDataBaseInterface mockAuthDataBase;
    late StreamController<User?> authStreamController;

    setUp(() {
      mockAuthDataBase = MockAuthDataBaseInterface();
      authStreamController = StreamController<User?>();
    });

    tearDown(() {
      authStreamController.close();
    });

    testWidgets(
      'MovieScaffold() should display the movie scaffold with parameters',
      (WidgetTester tester) async {
        //Given
        bool tappedButton = false;
        when(
          mockAuthDataBase.authStateChanges,
        ).thenAnswer((_) => authStreamController.stream);

        //When
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authDataBaseProvider.overrideWithValue(mockAuthDataBase),
            ],
            child: MaterialApp(
              home: MovieScaffold(
                title: 'title',
                backgroundColor: Colors.white,
                callBack: () {
                  tappedButton = true;
                },
                child: Text('text'),
              ),
            ),
          ),
        );

        //Then
        expect(find.text('title'), findsOneWidget);
        expect(find.text('text'), findsOneWidget);
        expect(tappedButton, false);
        expect(
          find.text(StringConstants.movieScaffoldButtonText),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(Scaffold),
            matching: find.byType(AppBar),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(Scaffold),
            matching: find.byType(SafeArea),
          ),
          findsAtLeastNWidgets(1),
        );
        expect(
          find.descendant(
            of: find.byType(Scaffold),
            matching: find.byType(Padding),
          ),
          findsAtLeastNWidgets(1),
        );
        expect(
          find.descendant(of: find.byType(AppBar), matching: find.byType(Text)),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(SafeArea),
            matching: find.byType(Text),
          ),
          findsAtLeastNWidgets(1),
        );
        expect(
          find.descendant(
            of: find.byType(Padding),
            matching: find.byType(ElevatedButton),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(Padding),
            matching: find.byType(Text),
          ),
          findsAtLeastNWidgets(1),
        );

        //When
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        //Then
        expect(tappedButton, true);
      },
    );

    testWidgets(
      'MovieScaffold() should display the movie scaffold without parameters',
      (WidgetTester tester) async {
        //Given
        when(
          mockAuthDataBase.authStateChanges,
        ).thenAnswer((_) => authStreamController.stream);

        //When
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authDataBaseProvider.overrideWithValue(mockAuthDataBase),
            ],
            child: MaterialApp(home: MovieScaffold(child: Text('text'))),
          ),
        );

        //Then
        expect(find.text('text'), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(Scaffold),
            matching: find.byType(AppBar),
          ),
          findsNothing,
        );
        expect(
          find.descendant(
            of: find.byType(Scaffold),
            matching: find.byType(SafeArea),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(Scaffold),
            matching: find.byType(Padding),
          ),
          findsAtLeast(1),
        );
        expect(
          find.descendant(of: find.byType(AppBar), matching: find.byType(Text)),
          findsNothing,
        );
        expect(
          find.descendant(
            of: find.byType(SafeArea),
            matching: find.byType(Text),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(Padding),
            matching: find.byType(ElevatedButton),
          ),
          findsNothing,
        );
        expect(
          find.descendant(
            of: find.byType(Padding),
            matching: find.byType(Text),
          ),
          findsOneWidget,
        );
      },
    );
  });
}
