import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_quote_generator/main.dart';

void main() {
  testWidgets('Random quote generation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(RandomQuoteApp());

    // Verify that the initial quote is displayed.
    expect(find.text('Click the button to get a random quote!'), findsOneWidget);

    // Tap the 'Generate Quote' button and trigger a frame.
    await tester.tap(find.text('Generate Quote'));
    await tester.pump();

    // Verify that a new quote is displayed (not the initial one).
    expect(find.text('Click the button to get a random quote!'), findsNothing);
    expect(find.byType(Text), findsWidgets); // To ensure some text is present.

    // Tap the 'Share Quote' button and trigger a frame.
    await tester.tap(find.text('Share Quote'));
    await tester.pump();

    // Since sharing cannot be verified directly in tests, we just ensure the button works.
    // More complex checks might involve mocking the Share functionality.
  });
}
