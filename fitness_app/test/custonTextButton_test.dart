import 'package:fitness_app/widgets/customTextButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('CustomTextButton UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextButton(
          text: 'Test Text Button',
          onPressed: () {},
        ),
      ),
    ));

    // Check for the button text.
    expect(find.text('Test Text Button'), findsOneWidget);

    // Check for the presence of TextButton widget.
    expect(find.byType(TextButton), findsOneWidget);

    // Check for the presence of CustomTextButton widget.
    expect(find.byType(CustomTextButton), findsOneWidget);

    // Tap the button.
    await tester.tap(find.text('Test Text Button'));

    // Trigger a frame to rebuild the widget after the tap.
    await tester.pump();

    // Add any additional assertions or tests you need here.
  });
}
