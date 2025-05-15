import 'package:dojo_challenges/src/core/util/string_constants.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieScaffold test', () {
    testWidgets(
      'MovieScaffold() should display the movie scaffold with parameters',
      (WidgetTester tester) async {
        //Given
        bool tappedButton = false;

        //When
        await tester.pumpWidget(
          MaterialApp(
            home: MovieScaffold(
              title: 'title',
              backgroundColor: Colors.white,
              callBack: () {
                tappedButton = true;
              },
              child: Text('text'),
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

        //When
        await tester.pumpWidget(
          MaterialApp(home: MovieScaffold(child: Text('text'))),
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
          findsOneWidget,
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
