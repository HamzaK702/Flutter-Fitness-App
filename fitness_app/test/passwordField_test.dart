import 'package:fitness_app/widgets/passwordFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('PasswordField UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PasswordField(
          key: ValueKey('passwordFieldKey'),
          onSaved: (value) {},
          initialValue: '',
        ),
      ),
    ));

    // Check for the presence of TextFormField widget.
    expect(find.byType(TextFormField), findsOneWidget);

    // Check for the presence of PasswordField widget.
    expect(find.byType(PasswordField), findsOneWidget);

    // Verify the TextFormField has the correct key.
    final passwordField = find.byKey(ValueKey('passwordFieldKey'));
    expect(passwordField, findsOneWidget);

    // Verify the hintText and prefixIcon.
    final inputDecoration = tester.widget<TextField>(find.byType(TextField));
     
    expect(inputDecoration.decoration?.prefixIcon, isA<Icon>());

    // Add any additional assertions or tests you need here.
  });

  testWidgets('PasswordField Validation Test (Short Password)', (WidgetTester tester) async {
    // Build the widget with a short password.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PasswordField(
          key: ValueKey('passwordFieldKey'),
          onSaved: (value) {},
          initialValue: '',
        ),
      ),
    ));

    // Tap on the TextFormField to focus.
    await tester.tap(find.byType(TextFormField));
    await tester.pump();

    // Enter a short password.
    await tester.enterText(find.byType(TextFormField), 'short');
    await tester.pump();

    // Verify that the error message is displayed.
    expect(find.text('Password must be at least 7 characters long.'), findsOneWidget);

    // Add any additional assertions or tests you need here.
  });

  testWidgets('PasswordField Validation Test (Valid Password)', (WidgetTester tester) async {
    // Build the widget with a valid password.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PasswordField(
          key: ValueKey('passwordFieldKey'),
          onSaved: (value) {},
          initialValue: '',
        ),
      ),
    ));

    // Tap on the TextFormField to focus.
    await tester.tap(find.byType(TextFormField));
    await tester.pump();

    // Enter a valid password.
    await tester.enterText(find.byType(TextFormField), 'password123');
    await tester.pump();

    // Verify that there are no error messages.
    expect(find.text('Password must be at least 7 characters long.'), findsNothing);

    // Add any additional assertions or tests you need here.
  });
}
