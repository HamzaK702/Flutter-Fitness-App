import 'package:fitness_app/widgets/CustomCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('SectionCard UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SectionCard(
          backgroundColor: Colors.blue, // Replace with your desired color
          title: 'Sample Title',
          duration: '5MIN',
        ),
      ),
    ));

    // Check for the presence of Card widget.
    expect(find.byType(Card), findsOneWidget);

    // Check for the presence of SectionCard widget.
    expect(find.byType(SectionCard), findsOneWidget);

    // Check for the presence of Text widget for title.
    expect(find.text('Sample Title'), findsOneWidget);

    // Check for the presence of Text widget for duration.
    expect(find.text('5MIN'), findsOneWidget);

    // Add any additional assertions or tests you need here.
  });
}
