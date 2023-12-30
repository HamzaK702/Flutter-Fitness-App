import 'package:fitness_app/widgets/functionalityCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('CustomCard UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomCard(
          color: Colors.blue, // Replace with your desired color
          textcolor: Colors.white, // Replace with your desired text color
          text: 'Sample Text',
          onTap: () {},
        ),
      ),
    ));

    // Check for the presence of InkWell widget.
    expect(find.byType(InkWell), findsOneWidget);

    // Check for the presence of CustomCard widget.
    expect(find.byType(CustomCard), findsOneWidget);

    // Check for the presence of Text widget for the text.
    expect(find.text('Sample Text'), findsOneWidget);

    // Add any additional assertions or tests you need here.
  });
}
