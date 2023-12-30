import 'package:fitness_app/widgets/customButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('CustomElevatedButton UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomElevatedButton(
          buttonText: 'Test Button',
          onPressed: () {},
        ),
      ),
    ));

    // Check for the button text.
    expect(find.text('Test Button'), findsOneWidget);

    // Check for the presence of ElevatedButton widget.
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Check for the presence of CustomElevatedButton widget.
    expect(find.byType(CustomElevatedButton), findsOneWidget);

    // Tap the button.
    await tester.tap(find.text('Test Button'));

    // Trigger a frame to rebuild the widget after the tap.
    await tester.pump();

    // Add any additional assertions or tests you need here.
  });
}
