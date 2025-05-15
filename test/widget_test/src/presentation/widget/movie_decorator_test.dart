import 'package:dojo_challenges/src/presentation/widget/movie_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MovieDecorator() should display the movie decorator', (
    WidgetTester tester,
  ) async {
    //Given

    //When
    await tester.pumpWidget(
      MaterialApp(home: MovieDecorator(child: Text('text'))),
    );

    //Then
    expect(find.text('text'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(Padding),
        matching: find.byType(Container),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(Container),
        matching: find.byType(Padding),
      ),
      findsNWidgets(2),
    );
    expect(
      find.descendant(of: find.byType(Padding), matching: find.byType(Text)),
      findsOneWidget,
    );
  });
}
