import 'dart:async';

import 'package:dojo_challenges/src/core/util/string_constants.dart';
import 'package:dojo_challenges/src/di/provider/provider.dart';
import 'package:dojo_challenges/src/domain/data_base/auth_data_base_interface.dart';
import 'package:dojo_challenges/src/presentation/view/home_page.dart';
import 'package:dojo_challenges/src/presentation/widget/data_widget.dart';
import 'package:dojo_challenges/src/presentation/widget/splash_screen.dart';
import 'package:dojo_challenges/src/presentation/widget/unsuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock_data/mock_data.dart';
import '../view/home_page_test.mocks.dart';

@GenerateMocks([AuthDataBaseInterface])
void main() {
  group('HomePage test', () {
    late Exception exception;
    late AuthDataBaseInterface mockAuthDataBase;
    late StreamController<User?> authStreamController;

    setUp(() {
      exception = Exception();
      mockAuthDataBase = MockAuthDataBaseInterface();
      authStreamController = StreamController<User?>.broadcast();
    });

    tearDown(() {
      authStreamController.close();
    });

    testWidgets('HomePage should display the home page with data widget', (
      WidgetTester tester,
    ) async {
      //Given
      when(
        mockAuthDataBase.authStateChanges,
      ).thenAnswer((_) => authStreamController.stream);

      //When
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            movieProvider(
              true,
            ).overrideWith((ref) async => successDataStateMock),
            movieProvider(
              false,
            ).overrideWith((ref) async => voteCountSuccessDataStateMock),
            authDataBaseProvider.overrideWithValue(mockAuthDataBase),
          ],
          child: const MaterialApp(home: HomePage()),
        ),
      );

      //Then
      expect(find.text('title'), findsNothing);
      expect(
        find.text('${StringConstants.errorMessage}${exception.toString()}'),
        findsNothing,
      );
      expect(find.byType(DataWidget), findsNothing);
      expect(find.byType(Unsuccess), findsNothing);
      expect(find.byType(SplashScreen), findsOneWidget);

      //When
      await tester.pumpAndSettle();

      //Then
      expect(find.text('title'), findsNWidgets(2));
      expect(
        find.text('${StringConstants.errorMessage}${exception.toString()}'),
        findsNothing,
      );
      expect(find.byType(DataWidget), findsOneWidget);
      expect(find.byType(Unsuccess), findsNothing);
      expect(find.byType(SplashScreen), findsNothing);

      //When
      final dataWidget = tester.widget<DataWidget>(find.byType(DataWidget));
      dataWidget.callback();
      await tester.pumpAndSettle();

      //Then
      expect(find.text('title'), findsOneWidget);
      expect(
        find.text('${StringConstants.errorMessage}${exception.toString()}'),
        findsNothing,
      );
      expect(find.byType(Unsuccess), findsNothing);
      expect(find.byType(DataWidget), findsOneWidget);
      expect(find.byType(SplashScreen), findsNothing);
    });

    testWidgets('HomePage should display the home page with unsuccess', (
      WidgetTester tester,
    ) async {
      //Given
      when(
        mockAuthDataBase.authStateChanges,
      ).thenAnswer((_) => authStreamController.stream);

      //When
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            movieProvider(true).overrideWith((ref) async {
              throw exception;
            }),
            authDataBaseProvider.overrideWithValue(mockAuthDataBase),
          ],
          child: const MaterialApp(home: HomePage()),
        ),
      );

      //Then
      expect(find.text('title'), findsNothing);
      expect(
        find.text('${StringConstants.errorMessage}${exception.toString()}'),
        findsNothing,
      );
      expect(find.byType(Unsuccess), findsNothing);
      expect(find.byType(DataWidget), findsNothing);
      expect(find.byType(SplashScreen), findsOneWidget);

      //When
      await tester.pumpAndSettle();

      //Then
      expect(find.text('title'), findsNothing);
      expect(
        find.text('${StringConstants.errorMessage}${exception.toString()}'),
        findsOneWidget,
      );
      expect(find.byType(Unsuccess), findsOneWidget);
      expect(find.byType(DataWidget), findsNothing);
      expect(find.byType(SplashScreen), findsNothing);
    });
  });
}
