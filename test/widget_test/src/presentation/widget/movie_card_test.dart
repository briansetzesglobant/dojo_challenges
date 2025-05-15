import 'package:cached_network_image/cached_network_image.dart';
import 'package:dojo_challenges/src/core/util/api_service_constants.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_card.dart';
import 'package:dojo_challenges/src/presentation/widget/movie_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MovieCard() should display the movie card', (
    WidgetTester tester,
  ) async {
    //Given

    //When
    await tester.pumpWidget(
      MaterialApp(
        home: MovieCard(
          title: 'title',
          image:
              '${ApiServiceConstants.imageNetwork}/8LpnMIqpRiwxpbGR33ALCmVl7gj.jpg',
        ),
      ),
    );

    expect(find.text('title'), findsOneWidget);
    expect(find.byType(Image), findsAtLeastNWidgets(1));
    //Then
    expect(
      find.descendant(
        of: find.byType(MovieDecorator),
        matching: find.byType(Column),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(Column),
        matching: find.byType(FittedBox),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Column), matching: find.byType(SizedBox)),
      findsAtLeastNWidgets(1),
    );
    expect(
      find.descendant(of: find.byType(Column), matching: find.byType(Expanded)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(FittedBox), matching: find.byType(Text)),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(Expanded),
        matching: find.byType(ClipOval),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(ClipOval),
        matching: find.byType(CachedNetworkImage),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(CachedNetworkImage),
        matching: find.byType(Image),
      ),
      findsAtLeastNWidgets(1),
    );
  });
}
