import 'package:dojo_challenges/src/presentation/widget/data_widget.dart';
import 'package:dojo_challenges/src/presentation/widget/success.dart';
import 'package:dojo_challenges/src/presentation/widget/unsuccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mock_data/mock_data.dart';

void main() {
  group('DataWidget test', () {
    testWidgets(
      'DataWidget() should display the data widget with the success state',
      (WidgetTester tester) async {
        //Given

        //When
        await tester.pumpWidget(
          MaterialApp(
            home: DataWidget(data: successDataStateMock, callback: () {}),
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

      //When
      await tester.pumpWidget(
        MaterialApp(
          home: DataWidget(data: emptyDataStateMock, callback: () {}),
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

      //When
      await tester.pumpWidget(
        MaterialApp(
          home: DataWidget(data: failedDataStateMock, callback: () {}),
        ),
      );

      //Then
      expect(find.byType(Success), findsNothing);
      expect(find.byType(Unsuccess), findsOneWidget);
    });
  });
}
