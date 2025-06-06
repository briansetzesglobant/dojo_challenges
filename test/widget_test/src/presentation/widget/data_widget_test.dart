import 'dart:async';

import 'package:dojo_challenges/src/di/provider/provider.dart';
import 'package:dojo_challenges/src/domain/data_base/auth_data_base_interface.dart';
import 'package:dojo_challenges/src/presentation/widget/data_widget.dart';
import 'package:dojo_challenges/src/presentation/widget/success.dart';
import 'package:dojo_challenges/src/presentation/widget/unsuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_data/mock_data.dart';
import 'data_widget_test.mocks.dart';

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

  group('DataWidget test', () {
    testWidgets(
      'DataWidget() should display the data widget with the success state',
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
            child: MaterialApp(
              home: DataWidget(data: successDataStateMock, callback: () {}),
            ),
          ),
        );

        //Then
        expect(find.byType(Success), findsOneWidget);
        expect(find.byType(Unsuccess), findsNothing);
      },
    );

    testWidgets('DataWidget should display the data widget the empty state', (
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
            home: DataWidget(data: emptyDataStateMock, callback: () {}),
          ),
        ),
      );

      //Then
      expect(find.byType(Success), findsNothing);
      expect(find.byType(Unsuccess), findsOneWidget);
    });

    testWidgets('DataWidget should display the data widget the failed state', (
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
            home: DataWidget(data: failedDataStateMock, callback: () {}),
          ),
        ),
      );

      //Then
      expect(find.byType(Success), findsNothing);
      expect(find.byType(Unsuccess), findsOneWidget);
    });
  });
}
