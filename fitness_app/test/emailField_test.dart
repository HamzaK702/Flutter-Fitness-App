import 'package:fitness_app/widgets/emailFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('EmailField UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: EmailField(
          key: ValueKey('emailFieldKey'),
          onSaved: (value) {},
          initialValue: '',
        ),
      ),
    ));

    // Check for the presence of TextFormField widget.
    expect(find.byType(TextFormField), findsOneWidget);

    // Check for the presence of EmailField widget.
    expect(find.byType(EmailField), findsOneWidget);

    // Verify the TextFormField has the correct key.
    final emailField = find.byKey(ValueKey('emailFieldKey'));
    expect(emailField, findsOneWidget);

    // Verify the hintText and prefixIcon.
    final inputDecoration = tester.widget<TextField>(find.byType(TextField));
     
    expect(inputDecoration.decoration?.prefixIcon, isA<Icon>());

    // Add any additional assertions or tests you need here.
  });

  testWidgets('EmailField Validation Test', (WidgetTester tester) async {
    // Build the widget with an invalid email address.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: EmailField(
          key: ValueKey('emailFieldKey'),
          onSaved: (value) {},
          initialValue: '',
        ),
      ),
    ));

    // Tap on the TextFormField to focus.
    await tester.tap(find.byType(TextFormField));
    await tester.pump();

    // Enter an invalid email address.
    await tester.enterText(find.byType(TextFormField), 'invalidemail');
    await tester.pump();

    // Verify that the error message is displayed.
    expect(find.text('Please enter a valid email address.'), findsOneWidget);

    // Add any additional assertions or tests you need here.
  });

  testWidgets('EmailField Validation Test (Valid Email)', (WidgetTester tester) async {
    // Build the widget with a valid email address.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: EmailField(
          key: ValueKey('emailFieldKey'),
          onSaved: (value) {},
          initialValue: '',
        ),
      ),
    ));

    // Tap on the TextFormField to focus.
    await tester.tap(find.byType(TextFormField));
    await tester.pump();

    // Enter a valid email address.
    await tester.enterText(find.byType(TextFormField), 'valid@email.com');
    await tester.pump();

    // Verify that there are no error messages.
    expect(find.text('Please enter a valid email address.'), findsNothing);

    // Add any additional assertions or tests you need here.
  });
}
