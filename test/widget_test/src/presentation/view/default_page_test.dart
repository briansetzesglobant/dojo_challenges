import 'package:dojo_challenges/src/core/util/string_constants.dart';
import 'package:dojo_challenges/src/presentation/view/default_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DefaultPage() should display the default page', (
    WidgetTester tester,
  ) async {
    //Given

    //When
    await tester.pumpWidget(const MaterialApp(home: DefaultPage()));

    //Then
    expect(find.text(StringConstants.defaultPageMessage), findsOneWidget);
    expect(
      find.descendant(of: find.byType(Scaffold), matching: find.byType(Center)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Center), matching: find.byType(Padding)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Padding), matching: find.byType(Text)),
      findsOneWidget,
    );
  });
}
