import 'package:dojo_challenges/src/core/util/asset_constants.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_scaffold.dart';
import 'package:dojo_challenges/src/presentation/widget/unsuccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Unsuccess() should display the unsuccess', (
    WidgetTester tester,
  ) async {
    //Given

    //When
    await tester.pumpWidget(
      MaterialApp(
        home: Unsuccess(text: 'text', image: AssetConstants.homePageEmpty),
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
      findsOneWidget,
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
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Column), matching: find.byType(Text)),
      findsOneWidget,
    );
  });
}
